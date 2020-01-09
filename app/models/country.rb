class Country < ApplicationRecord
  has_one :country_currency
  has_one :currency, through: :country_currency

  validates :name, :code, presence: true
  validates :code, uniqueness: true
end
