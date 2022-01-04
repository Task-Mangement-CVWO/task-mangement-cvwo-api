class AuthenticationController < ApplicationController
  skip_before_action :auth_middleware, only: %i[login register]

  def login
    begin
      user =
        User
          .find_by(username: params['username'])
          .try(:authenticate, params['password'])

      if !user
        render json: { message: 'Incorrect Credentials' }, status: 401
        return
      end

      payload = { user_id: user.id }
      token = JWT.encode(payload, ENV['TOKEN_SECRET'], 'HS256')
      render json: { data: { accessToken: token } }
    rescue ActiveRecord::ActiveRecordError
      render json: { message: 'Active record error' }, status: 400
      return
    rescue => e
      render json: { error: e }, status: 400
      return
    rescue Exception => e
      render json: { error: e }, status: 400
      return
      raise
    end
  end

  def register
    begin
      user = User.find_by(username: params['username'])
      if user
        render json: { message: 'User Already Exists' }, status: 400
        return
      end
      created_user =
        User.create!(
          username: params['username'],
          password: params['password'],
          password_confirmation: params['password_confirmation']
        )
      if !created_user
        render json: { message: 'An error has occured' }, status: 400
        return
      end
      render json: { message: 'User Successfully Created' }, status: 201
    rescue ActiveRecord::ActiveRecordError
      render json: { message: 'Active record error' }, status: 400
      return
    rescue => e
      render json: { error: e }, status: 400
      return
    rescue Exception => e
      render json: { error: e }, status: 400
      return
      raise
    end
  end
end
