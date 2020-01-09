class Currency < ApplicationRecord
  has_many :country_currencies
  has_many :countries, through: :country_currencies

  validates :name, :code, presence: true
  validates :code, uniqueness: true
end
