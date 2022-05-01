# frozen_string_literal: true

RSpec.describe 'PATCH /api/v1/admin/excels/:id', type: :request do
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }
  let!(:excel) { create(:excel, user_id: user.id)  }

  describe 'Succesfully updates fees data from excel data' do
    before do
      patch "/api/v1/admin/excels/#{excel.id}",
      params: {
        fees: -14.31
      },
      headers: headers
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns data from fees' do
      expect(response_json["fees"]).to eq -14.31
    end
  end

  describe 'Succesfully updates trade data from excel data' do
    before do
      patch "/api/v1/admin/excels/#{excel.id}",
      params: {
        data: [
          {Ticker: "AMC", NetProfit: 234234},
          {Ticker: "FB", NetProfit: 23.00},
          {Ticker: "AMZN", NetProfit: 234234},
          {Ticker: "AAPL", NetProfit: 23.00},
          {Ticker: "MSFT", NetProfit: 234234},
          {Ticker: "YTEN", NetProfit: 23.00},
          {Ticker: "GSUM", NetProfit: 234234},
          {Ticker: "CASA", NetProfit: 23.00},
          {Ticker: "SAVA", NetProfit: 234234},
          {Ticker: "FRGE", NetProfit: 23.00},
          {Ticker: "GME", NetProfit: 234234},
          {Ticker: "NEW DATA", NetProfit: 23.00},
        ]
      },
      headers: headers
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns full range of data when subscriber' do
      expect(response_json['data'].count).to eq 12
    end

    it 'returns updatd data set' do
      expect(response_json['data'][0]['NetProfit']).to eq "234234"
      expect(response_json['data'][11]['Ticker']).to eq "NEW DATA"
    end
  end
end