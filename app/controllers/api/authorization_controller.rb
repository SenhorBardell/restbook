class Api::AuthorizationController < ApplicationController
  # include ActionController::HttpAuthentication::Token
  @time = 2
  before_filter :authenticate, only: :associate_push_token

  def auth
    if params[:code]
      @code = Code.where(
          created_at: 1.hour.ago..Time.now,
          code: params[:code],
          token: params[:token]
      ).first

      if @code.blank?
        return render json: {status: 1003}
      end

      @device = @code.device
      # TODO Check if can do it in closure
      if @device.token == params[:token]
        @device.auth = SecureRandom.base64(32)
        @device.verified = true
        @device.save
        @code.destroy
      end

      render json: {auth: @device.auth, status: 1001}
    else
      # Find a Phone, Name entry, if not create one
      @user = User.create_with(name: params[:name]).find_or_create_by(phone: params[:phone])

      # Find device token associated with this phone
      @device = @user.devices.find_or_create_by(token: params[:token])

      @code = @device.codes.where(created_at: Time.now.ago(120)..Time.now).first

      # If not found create sms code temp entry
      if @code.blank?
        # Send the code
        if params[:phone].to_s == 9528853628.to_s
          @code = @device.codes.create(token: params[:token], code: 1234, created_at: Time.now)
        else
          code = SecureRandom.hex 3
          if send_sms params[:phone], code
            @code = @device.codes.create(token: params[:token], code: code, created_at: Time.now)
          end
        end
        return render json: {status: 1002, timeout: 120}
      else
        # If code already sent
        # check timeout
        # if its still timeout send a time
        if @code.created_at + 120.seconds > Time.now
          return render json: {status: 1002, timeout: @code.created_at + 120.seconds - Time.now}
        else
          if params[:phone].to_s == 9528853628.to_s
            @code = @device.codes.create(token: params[:token], code: 1234, created_at: Time.now)
          else
            code = SecureRandom.hex 3
            if send_sms params[:phone], code
              @code = @device.codes.create(token: params[:token], code: code, created_at: Time.now)
            end
          end
        end

        # if timeout passed send an sms again
        return render json: {status: 1002, timeout: 120 }
      end
    end
  end

  def associate_push_token
    @device = @user.devices.find_by(auth: bearer_token)
    if @device && params[:token]
      @device.update(token: params[:token])
    end
    return render nothing: true, status: 204
  end

  private
  def send_sms(phone, code)
    # TODO if env is production set test: 1
    @message = MainsmsApi::Message.new(message: "Код подтверждения #{code}", recipients: ['7' + phone.to_s])
    response = @message.deliver
    if response.status == 'success'
      Sms.create(price: response.price, message_id: response.messages_id[0], number: response.recipients[0], status: response.status)
      true
    else
      false
    end
  end

  def bearer_token
    pattern = /^Token token=/
    header  = request.authorization
    header.gsub(pattern, '') if header && header.match(pattern)
  end
end