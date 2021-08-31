# frozen_string_literal: true

RSpec.describe 'POST /api/v1/excels', type: :request do
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

  describe 'Succesfully creates trade from excel data' do
    before do
      post '/api/v1/excels',
      params: {
        excel: {
          data: [
            {Ticker: "AMC", NetProfit: 234234},
            {Ticker: "FB", NetProfit: 23.00}
          ]
        }
      },
      headers: headers
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns value from grossData array' do
      expect(response_json["data"][0]["Ticker"]).to eq "AMC"
      expect(response_json["data"][1]["NetProfit"]).to eq "23.0"
    end
  end

  describe 'unsuccesfully creates trade when no User' do
    before do
      post '/api/v1/excels',
      params: {
        excel: {
          data: [
            {Ticker: "AMC", NetProfit: 234234},
            {Ticker: "FB", NetProfit: 23.00}
          ]
        }
      }
    end

    it 'returns a 401 response status' do
      expect(response).to have_http_status 401
    end
  end

  describe 'succesfully creates trade with only fees data' do
    before do
      post '/api/v1/excels',
      params: {
        excel: {
          fees: 23.32
        }
      },
      headers: headers
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns a 200 response status' do
      expect(response_json["fees"]).to eq 23.32
    end
  end
end