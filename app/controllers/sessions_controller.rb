class SessionsController < ApplicationController
    def create
      user = User.find_by(email: params[:email])
  
      if user&.authenticate(params[:password])
        session[:user_id] = user.id
        render json: { message: 'Login successful', user: user }, status: :ok
      else
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end
    end
  
    def destroy
      session[:user_id] = nil
      head :no_content
    end
  
    def show
      if session[:user_id]
        user = User.find(session[:user_id])
        render json: { user: user }, status: :ok
      else
        render json: { error: 'Not logged in' }, status: :unauthorized
      end
    end
  end
  