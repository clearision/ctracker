class UserSession
  attr_reader :username, :password

  def initialize username, password
    @username = username
    @password = password
  end

  def valid?
    username.present? && password.present? && user.present? && valid_user?
  end

  def user
    @user ||= User.find_by_username username
  end

  private

    def valid_user?
      user.authenticate password
    end
end
