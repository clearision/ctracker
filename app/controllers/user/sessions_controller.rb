class User::SessionsController < ApplicationController
  def create
    if user_session.valid?
      render json: {
          message: 'You are signed in',
          auth_token: user_session.user.authentication_token
        },
        status: :ok
    else
      render json: { message: 'Incorrect Username or Password' }, status: :unauthorized
    end
  end

  private

    def user_session
      @user_session ||= UserSession.new(permitted_params[:username], permitted_params[:password])
    end

    def permitted_params
      params.permit(:username, :password)
    end
end
