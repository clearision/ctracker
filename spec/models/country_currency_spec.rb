require 'rails_helper'

RSpec.describe CountryCurrency, type: :model do
  let!(:country) { create :country, name: 'Ukraine', code: 'ua' }
  let!(:currency) { create :currency, name: 'Hryvnia', code: 'UAH' }

  describe 'validations' do
    subject { country_currency.valid? }

    let(:country_currency) { build :country_currency }

    context 'when no country and currence provided' do
      it { is_expected.to be_falsey }
    end

    context 'with only country' do
      let(:country_currency) { build :country_currency, country: country }

      it { is_expected.to be_falsey }
    end

    context 'with both country and code provided' do
      let(:country_currency) { build :country_currency, country: country, currency: currency }

      it { is_expected.to be_truthy }
    end
  end

  describe '#save' do
    subject { country_currency.save }

    let(:country_currency) { build :country_currency, country: country, currency: currency }

    it 'saves the record' do
      expect{ subject }.to change{ CountryCurrency.count }.from(0).to(1)
    end
  end
end
