# frozen_string_literal: true

RSpec.describe 'GET /api/v1/trades', type: :request do
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let!(:setup_user) { create(:setup, user_id: user.id)  }
  let!(:setup) do 
    3.times do
      create(:setup)
    end
  end
  let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

  describe 'Succesfully indexes all users trades' do
    before do
      get '/api/v1/setups',
      headers: headers
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns 1 setup' do
      expect(response_json.count).to eq 1
    end
  end

  describe 'Unsuccesfully indexes trades if not logged in' do
    before do
      get '/api/v1/setups'
    end

    it 'returns a 401 response status' do
      expect(response).to have_http_status 401
    end

    it 'returns not authorized error message' do
      expect(response_json['errors'][0]).to eq "You need to sign in or sign up before continuing."
    end
  end
end