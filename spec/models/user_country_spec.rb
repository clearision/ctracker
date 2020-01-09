require 'rails_helper'

RSpec.describe UserCountry, type: :model do
  let!(:country) { create :country, name: 'Ukraine', code: 'ua' }
  let!(:user) { create :user, username: 'admin', password: 'Passw0rd' }

  describe 'validations' do
    subject { user_country.valid? }

    let(:user_country) { build :user_country }

    context 'when no country and currency provided' do
      it { is_expected.to be_falsey }
    end

    context 'with only country' do
      let(:user_country) { build :user_country, country: country }

      it { is_expected.to be_falsey }
    end

    context 'with both country and currency provided' do
      let(:user_country) { build :user_country, country: country, user: user }

      it { is_expected.to be_truthy }
    end
  end

  describe '#save' do
    subject { user_country.save }

    let(:user_country) { build :user_country, country: country, user: user }

    it 'saves the record' do
      expect{ subject }.to change{ UserCountry.count }.from(0).to(1)
    end
  end
end
