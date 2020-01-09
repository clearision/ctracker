class UserCountry < ApplicationRecord
  belongs_to :user
  belongs_to :country

  validates :user, :country, presence: true
end
