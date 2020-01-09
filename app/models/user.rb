class User < ApplicationRecord
  has_secure_password

  has_many :user_currencies
  has_many :currencies, through: :user_currencies

  has_many :user_countries
  has_many :countries, through: :user_countries

  validates :username, presence: true, uniqueness: true

  before_save :ensure_authentication_token

  private

    def ensure_authentication_token
      return if self.authentication_token.present?

      self.authentication_token = SecureRandom.hex
    end
end
