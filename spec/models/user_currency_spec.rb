require 'rails_helper'

RSpec.describe UserCurrency, type: :model do
  let!(:currency) { create :currency, name: 'Hryvnia', code: 'UAH' }
  let!(:user) { create :user, username: 'admin', password: 'Passw0rd' }

  describe 'validations' do
    subject { user_currency.valid? }

    let(:user_currency) { build :user_currency }

    context 'when no currency and user provided' do
      it { is_expected.to be_falsey }
    end

    context 'with only currency' do
      let(:user_currency) { build :user_currency, currency: currency }

      it { is_expected.to be_falsey }
    end

    context 'with both currency and user provided' do
      let(:user_currency) { build :user_currency, currency: currency, user: user }

      it { is_expected.to be_truthy }
    end
  end

  describe '#save' do
    subject { user_currency.save }

    let(:user_currency) { build :user_currency, currency: currency, user: user }

    it 'saves the record' do
      expect{ subject }.to change{ UserCurrency.count }.from(0).to(1)
    end
  end
end
