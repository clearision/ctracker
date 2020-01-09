class CountryCurrency < ApplicationRecord
  belongs_to :country
  belongs_to :currency

  validates :country, :currency, presence: true
end
