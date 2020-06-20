# frozen_string_literal: true

RSpec.describe 'GET /api/v1/setups/:id', type: :request do
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }
  let(:user2) { create(:user, email: "wronguser@mail.com", nickname: "Userman2") }
  let(:credentials2) { user2.create_new_auth_token }
  let!(:headers2) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials2) }
  let!(:setup) { create(:setup, user_id: user.id)  }

  describe 'Succesfully shows setup' do
    before do
      get "/api/v1/setups/#{setup.id}",
      headers: headers
    end
    
    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns New Strat Setup' do
      expect(response_json['name']).to eq "New Strat"
    end
  end

  describe 'UnSuccesfully shows setup when not authorized' do
    before do
      get "/api/v1/setups/#{setup.id}",
      headers: headers2
    end
    
    it 'returns a 401 response status' do
      expect(response).to have_http_status 401
    end

    it 'returns New Strat Setup' do
      binding.pry
      expect(response_json['errors'][0]).to eq "You may not view this data"
    end
  end
end