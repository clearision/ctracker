require 'rails_helper'

RSpec.describe UserSession, type: :model do
  let!(:user) { create :user, username: 'admin', password: 'Passw0rd' }
  let(:session) { described_class.new }

  describe 'validations' do
    subject { session.valid? }

    context 'with wrong credentials' do
      let(:session) { described_class.new 'user1', 'password' }

      it { is_expected.to be_falsey }
    end

    context 'with correct credentials' do
      let(:session) { described_class.new 'admin', 'Passw0rd' }

      it { is_expected.to be_truthy }
    end
  end
end
