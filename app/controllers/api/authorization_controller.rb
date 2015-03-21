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
        @device.auth = SecureRandom.base64(16)
        @device.verified = true
        @device.save
        @code.destroy
      end

      render json: {auth: @device.auth, status: 1001}
    else
      # Find a Phone, Name entry, if not create one
      @user = User.find_or_create_by(phone: params[:phone])

      # Find device token associated with this phone
      @device = @user.devices.find_or_create_by(token: params[:token])

      # @code = @device.codes.where("created_at BETWEEN #{@start_date} AND #{@end_date}").first
      @code = @device.codes.where(created_at: Time.now.ago(120)..Time.now).first
      # @code = @device.codes.where("created_at < (CURRENT_TIMESTAMP - INTERVAL '120 seconds')").first

      # If not found create sms code temp entry
      puts "Blank #{@code.blank?}"
      if @code.blank?
        @code = @device.codes.create(token: params[:token], code: 1234, created_at: Time.now)
        # @message = MainsmsApi::Message.new(sender: '79211040339', message: "Код подтверждения #{@smscode}", recipients: [@user.phone])
        # response = @message.deliver
        # Send the code
        return render json: {status: 1002, timeout: 120}
      else
        # If code already sent
        # check timeout
        # if its still timeout send a time
        if @code.created_at + 120.seconds > Time.now
          return render json: {status: 1002, timeout: @code.created_at + 120.seconds - Time.now}
        else
          @code = @device.codes.create(token: params[:token], code: 1234, created_at: Time.now)
        end

        # if timeout passed send an sms again
        return render json: {status: 1002, timeout: 120 }
      end
      # Send sms code, via mainsms_api

    end
  end

  private
  def send_sms(phone, code)
    puts 'Sending sms'
  end
end