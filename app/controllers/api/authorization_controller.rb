class Api::AuthorizationController < ApplicationController
  @time = 2

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
        code = SecureRandom.hex 3
        if send_sms params[:phone], code
          @code = @device.codes.create(token: params[:token], code: code, created_at: Time.now)
        end
        # Send the code
        return render json: {status: 1002, timeout: 120}
      else
        # If code already sent
        # check timeout
        # if its still timeout send a time
        if @code.created_at + 120.seconds > Time.now
          return render json: {status: 1002, timeout: @code.created_at + 120.seconds - Time.now}
        else
          code = SecureRandom.hex 3
          if send_sms params[:phone], code
            @code = @device.codes.create(token: params[:token], code: code, created_at: Time.now)
          end
        end

        # if timeout passed send an sms again
        return render json: {status: 1002, timeout: 120 }
      end
    end
  end

  private
  def send_sms(phone, code)
    @message = MainsmsApi::Message.new(sender: '7' + phone.to_s, message: "Код подтверждения #{code}", recipients: [@user.phone])
    @message.deliver
  end
end