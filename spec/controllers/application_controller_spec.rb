require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  let!(:user) { create :user, username: 'admin', password: 'Passw0rd' }
  let(:params) { {} }

  def dispatch method, path
    send method, path, { format: :json, **params }
  end

  describe 'GET /dashboard.json' do
    subject { ActiveSupport::JSON.decode response.body }

    context 'when no auth_token provided' do
      before { dispatch :get, :dashboard }

      it { expect(response.status).to eq 401 }
    end

    context 'when auth_token is provided' do
      let(:params) { { params: { auth_token: user.authentication_token } } }

      before { dispatch :get, :dashboard }

      it { expect(response.status).to eq 200 }
      it { expect(subject.has_key? 'currencies').to be_truthy }
      it { expect(subject.has_key? 'collected_currencies').to be_truthy }
      it { expect(subject.has_key? 'visited_countries').to be_truthy }
    end
  end
end
