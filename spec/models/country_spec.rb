require 'rails_helper'

RSpec.describe Country, type: :model do
  describe 'validations' do
    subject { country.valid? }

    let(:country) { build :country }

    context 'when no name and code provided' do
      it { is_expected.to be_falsey }
    end

    context 'with only name' do
      let(:country) { build :country, name: 'Hryvnia' }

      it { is_expected.to be_falsey }
    end

    context 'with both name and code' do
      let(:country) { build :country, name: 'Hryvnia', code: 'UAH' }

      it { is_expected.to be_truthy }

      context 'with same code provided' do
        let!(:another_country) { create :country, name: 'Dollar', code: 'UAH' }

        it { is_expected.to be_falsey }
      end
    end
  end

  describe '#save' do
    subject { country.save }

    let(:country) { build :country, name: 'Hryvnia', code: 'UAH' }

    it 'saves the record' do
      expect{ subject }.to change{ Country.count }.from(0).to(1)
    end
  end
end
