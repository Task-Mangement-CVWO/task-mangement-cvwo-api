class ApplicationController < ActionController::API
  before_action :auth_middleware

  def auth_middleware
    token = request.headers['x-auth-token']
    if !token
      render json: { message: 'Request Malformed' }
      return
    end
    begin
      decoded_token =
        JWT.decode(token, ENV['TOKEN_SECRET'], true, { algorithm: 'HS256' })
      if decoded_token
        user_id = decoded_token[0]['user_id']
        @user = User.find_by(id: user_id)
      end
      return @user
    rescue JWT::DecodeError
      render json: { message: 'Malformed Token' }
      return
    end
  end
end
