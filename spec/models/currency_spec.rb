require 'rails_helper'

RSpec.describe Currency, type: :model do
  describe 'validations' do
    subject { currency.valid? }

    let(:currency) { build :currency }

    context 'when no name and code provided' do
      it { is_expected.to be_falsey }
    end

    context 'with only name' do
      let(:currency) { build :currency, name: 'Hryvnia' }

      it { is_expected.to be_falsey }
    end

    context 'with both name and code' do
      let(:currency) { build :currency, name: 'Hryvnia', code: 'UAH' }

      it { is_expected.to be_truthy }

      context 'with same code provided' do
        let!(:another_currency) { create :currency, name: 'Dollar', code: 'UAH' }

        it { is_expected.to be_falsey }
      end
    end
  end

  describe '#save' do
    subject { currency.save }

    let(:currency) { build :currency, name: 'Hryvnia', code: 'UAH' }

    it 'saves the record' do
      expect{ subject }.to change{ Currency.count }.from(0).to(1)
    end
  end
end
