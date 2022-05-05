# frozen_string_literal: true

RSpec.describe 'PATCH /api/v1/excels/:id', type: :request do
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }
  let!(:excel) { create(:excel, user_id: user.id)  }

  describe 'Succesfully updates fees from excel data' do
    before do
      patch "/api/v1/excels/#{excel.id}",
      params: {
        fees: -14.31
      },
      headers: headers
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'expects fees to equal -14.31' do
      expect(response_json['excel']['fees']).to eq -14.31
    end
  end

  describe 'Succesfully updates trade data from excel data' do
    before do
      patch "/api/v1/excels/#{excel.id}",
      params: {
        data: [
          {Ticker: "AMC", NetProfit: 234234},
          {Ticker: "FB", NetProfit: 23.00}
        ]
      },
      headers: headers
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns updated ticker data' do
      expect(response_json['excel']['data'][0]['NetProfit']).to eq "234234"
    end
  end

  describe 'Succesfully return limited updated trade data when not subscriber' do
    let(:user2) { create(:user, email: "user2@mail.com", nickname: "Userman2", role: "user") }
    let(:credentials2) { user2.create_new_auth_token }
    let!(:headers2) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials2) }
    let!(:excel2) { create(:excel, user_id:user2.id ) }
    before do
      patch "/api/v1/excels/#{excel2.id}",
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
          {Ticker: "DRYS", NetProfit: 1000000.00},
        ]
      },
      headers: headers2
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns updated ticker data' do
      expect(response_json['excel']['data'][9]['NetProfit']).to eq "1000000.0"
    end

    it 'returns limited data length to 10 entries' do
      expect(response_json['excel']['data'].length).to eq 10
    end

    it 'returns most previous data entries' do
      expect(response_json['excel']['data'][0]['Ticker']).to eq "AMZN"
    end
  end
end