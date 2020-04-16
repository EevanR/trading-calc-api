# frozen_string_literal: true

RSpec.describe 'GET /api/v1/trades', type: :request do
  let!(:headers) { { HTTP_ACCEPT: 'application/json' } }
  let!(:trade) do 
    3.times do
      create(:trade)
    end
  end

  describe 'Succesfully indexes all trades' do
    before do
      get '/api/v1/trades',
      headers: headers
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns 3 trades' do
      binding.pry
      expect(response_json.count).to eq 3
    end
  end
end