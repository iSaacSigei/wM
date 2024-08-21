require 'jwt'

class SessionsController < ApplicationController
  before_action :authorize_request, only: [:show, :destroy]

  # POST /login
  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = encode_token(user_id: user.id)
      render json: { message: 'Login successful', token: token }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  # DELETE /logout
  def destroy
    # For token-based auth, there's no need to explicitly log out as the token is stateless.
    # However, you could implement token invalidation or deletion logic here if needed.
    head :no_content
  end

  # GET /sessions
  def show
    render json: { user: @current_user }, status: :ok
  end

  private

  def encode_token(payload)
    JWT.encode(payload, Rails.application.secrets.secret_key_base, 'HS256')
  end

  def authorize_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    begin
      decoded_token = JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
      @current_user = User.find(decoded_token[0]['user_id'])
    rescue JWT::DecodeError
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end
end
