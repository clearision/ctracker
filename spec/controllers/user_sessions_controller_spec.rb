require 'rails_helper'

RSpec.describe User::SessionsController, type: :controller do
  let!(:user) { create :user, username: 'admin', password: 'Passw0rd' }
  let(:params) { {} }

  def dispatch method, path
    send method, path, { format: :json, **params }
  end

  describe 'POST /sessions.json' do
    subject { ActiveSupport::JSON.decode response.body }

    before { dispatch :post, :create }

    it { expect(subject['message']).to eq "Incorrect Username or Password" }
    it { expect(response.status).to eq 422 }

    context 'when credentials are correct' do
      let(:params) { { params: { username: 'admin', password: 'Passw0rd' } } }

      it { expect(subject['message']).to eq "You are signed in" }
      it { expect(response.status).to eq 200 }
    end
  end
end
