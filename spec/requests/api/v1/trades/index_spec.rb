# frozen_string_literal: true

RSpec.describe 'GET /api/v1/trades', type: :request do
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let!(:trade1) { create(:trade, user_id: user.id)  }
  let!(:trade) do 
    3.times do
      create(:trade)
    end
  end
  let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

  describe 'Succesfully indexes all users trades' do
    before do
      get '/api/v1/trades',
      headers: headers
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns 1 trade' do
      expect(response_json.count).to eq 1
    end
  end
end