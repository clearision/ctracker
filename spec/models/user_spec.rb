require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { user.valid? }

    let(:user) { build :user }

    context 'when no username and password provided' do
      it { is_expected.to be_falsey }
    end

    context 'with only username' do
      let(:user) { build :user, username: 'admin' }

      it { is_expected.to be_falsey }
    end

    context 'with both username and password' do
      let(:user) { build :user, username: 'admin', password: 'Passw0rd' }

      it { is_expected.to be_truthy }

      context 'with same username provided' do
        let!(:another_user) { create :user, username: 'admin', password: 'Passw0rd' }

        it { is_expected.to be_falsey }
      end
    end
  end

  describe '#save' do
    subject { user.save }

    let(:user) { build :user, username: 'admin', password: 'Passw0rd' }

    it 'saves the record' do
      expect{ subject }.to change{ User.count }.from(0).to(1)
    end

    context 'callbacks' do
      before { subject }

      it 'generates string auth token on save' do
        expect(user.reload.authentication_token.length).to eq 32
      end

      it 'generates password digest on save' do
        expect(user.reload.password_digest.length).to eq 60
      end
    end
  end
end
