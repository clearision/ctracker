require 'rails_helper'

RSpec.describe CountryVisitor do
  let!(:user) { create :user, username: 'admin', password: 'Passw0rd' }
  let(:country) { create :country, name: 'Ukraine', code: 'ua' }
  let(:currency) { create :currency, name: 'Hryvnia', code: 'UAH' }
  let!(:country_currency) { create :country_currency, country: country, currency: currency }
  let(:country_codes) { [] }
  let(:visitor) { described_class.new user, country_codes }

  describe '#visit!' do
    subject { visitor.visit! }

    it "doesn't create UserCountry" do
      expect{ subject }.not_to change{ UserCountry.count }
    end

    it "doesn't create UserCurrency" do
      expect{ subject }.not_to change{ UserCurrency.count }
    end

    context 'when country codes provided' do
      let(:country_codes) { ['ua'] }
      let(:user_country) { UserCountry.first }
      let(:user_currency) { UserCurrency.first }

      before { subject }

      it { expect(user_country.country).to eq country }
      it { expect(user_country.user).to eq user }
      it { expect(user_currency.currency).to eq currency }
      it { expect(user_currency.user).to eq user }
    end

    context 'when Ukraine is visited' do
      let!(:user_country) { create :user_country, user: user, country: country }
      let(:country_codes) { ['ua'] }

      it { expect{ subject }.to_not change(UserCountry, :count) }
      it { expect{ subject }.to_not change(UserCurrency, :count) }
    end

    context 'when Hryvnia is collected' do
      let!(:user_currency) { create :user_currency, user: user, currency: currency }
      let(:country_codes) { ['ua'] }

      it { expect{ subject }.to change{ UserCountry.count }.by(1) }
      it { expect{ subject }.to_not change(UserCurrency, :count) }
    end
  end
end
