module UserAuth

  private

    def authenticate_user!
      unless authentication_token.presence && current_user
        render json: { message: 'auth failed' }, status: :unauthorized
      end
    end

    def current_user
      @current_user ||= User.find_by_authentication_token authentication_token
    end

    def authentication_token
      @authentication_token ||= params[:auth_token].presence || session[:auth_token].presence
    end
end
