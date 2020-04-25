# frozen_string_literal: true

RSpec.describe 'POST /api/v1/trades', type: :request do
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

  describe 'Succesfully creates trade entry' do
    before do
      post '/api/v1/trades',
      params: { 
        trade: {
          ticker: "AMZN",
          entry: 1800.98,
          shares: 40,
          stop: 1800.00,
          setup: "Setup 1",
          date: "20/01/01",
          profit: 1000.00,
          trade_id: 2,
          open: "1799.50",
          high: "1900.00",
          low: "1798.50",
          close: "1900.00",
          vol: "4400009",
          prevClose: "1600.00",
          volAvg: 32000,
          mktCap: 32000000000,
          company: "Amazon",
          industry: "Consumer",
          user_id: user.id
        }
      }, 
      headers: headers
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end
  end

  describe 'Unsuccesfully creates trade entry with missing param' do
    before do
      post '/api/v1/trades',
      params: { 
        trade: {
          ticker: nil,
          entry: 1800.98,
          shares: 40,
          stop: 1800.00,
          setup: "Setup 1",
          date: "20/01/01",
          profit: 1000.00,
          trade_id: 2,
          user_id: user.id
        }
      }, 
      headers: headers
    end

    it 'returns a 422 response status' do
      expect(response).to have_http_status 422
    end

    it 'returns an error message' do
      expect(response_json['error'][0]).to eq "Ticker can't be blank"
    end
  end

  describe 'Unsuccesfully creates trade entry with missing param' do
    before do
      post '/api/v1/trades',
      params: { 
        trade: {
          ticker: "EMV",
          entry: 1800.98,
          shares: 40,
          stop: 1800.00,
          setup: "Setup 1",
          date: "20/01/01",
          profit: 1000.00,
          trade_id: 2
        }
      }
    end

    it 'returns a 401 not authenticated response status' do
      expect(response).to have_http_status 401
    end

    it 'returns an error message' do
      expect(response_json['errors'][0]).to eq "You need to sign in or sign up before continuing."
    end
  end
end