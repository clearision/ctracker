require 'rails_helper'

RSpec.describe DashboardPresenter do
  let!(:user) { create :user, username: 'admin', password: 'Passw0rd' }
  let(:country) { create :country, name: 'Ukraine', code: 'ua' }
  let(:currency) { create :currency, name: 'Hryvnia', code: 'UAH' }
  let!(:country_currency) { create :country_currency, country: country, currency: currency }

  let(:presenter) { described_class.new user }

  describe '#available_currencies' do
    subject { presenter.available_currencies }

    let(:available_currencies) {
      [
        {
          id: currency.id,
          code: currency.code,
          name: currency.name,
          countries: [
            {
              id: country.id,
              name: country.name,
              code: country.code,
              visited: false
            }
          ]
        }
      ]
    }

    it { is_expected.to eq available_currencies }

    context 'when currency is already collected' do
      let!(:user_currency) { create :user_currency, user: user, currency: currency }

      it { is_expected.to eq [] }
    end
  end

  describe '#visited_countries' do
    subject { presenter.visited_countries }

    it { is_expected.to eq [] }

    context 'when country is visited' do
      let!(:user_country) { create :user_country, user: user, country: country }

      it { is_expected.to eq [country] }
    end
  end

  describe '#collected_currencies' do
    subject { presenter.collected_currencies }

    it { is_expected.to eq [] }

    context 'when currency is collected' do
      let!(:user_currency) { create :user_currency, user: user, currency: currency }
      let(:expected_array) {
        [
          {
            code: currency.code,
            name: currency.name,
            collected_at: user_currency.created_at.strftime('%T'),
            currencies_collected: 1
          }
        ]
      }

      it { is_expected.to eq expected_array }
    end
  end
end
