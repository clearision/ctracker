require 'rails_helper'

RSpec.describe CountriesController, type: :controller do
  let!(:user) { create :user, username: 'admin', password: 'Passw0rd' }
  let(:params) { {} }

  def dispatch method, path
    send method, path, { format: :json, **params }
  end

  describe 'POST /countries/visit.json' do
    subject { ActiveSupport::JSON.decode response.body }

    context 'when no auth_token provided' do
      before { dispatch :post, :visit }

      it { expect(response.status).to eq 401 }
    end

    context 'when auth_token is provided' do
      let(:params) { { params: { auth_token: user.authentication_token } } }

      before do
        allow_any_instance_of(CountryVisitor).to receive(:visit!).and_return true
        dispatch :post, :visit
      end

      it { expect(response.status).to eq 200 }
      it { expect(subject).to eq({ visited_countries: [] }.with_indifferent_access) }
    end
  end
end
