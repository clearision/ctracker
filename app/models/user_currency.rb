class UserCurrency < ApplicationRecord
  belongs_to :user
  belongs_to :currency

  validates :user, :currency, presence: true
end
