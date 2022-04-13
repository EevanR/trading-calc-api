# frozen_string_literal: true

RSpec.describe 'PATCH /api/v1/excels/:id', type: :request do
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }
  let!(:excel) { create(:excel, user_id: user.id)  }
  let!(:excel2) { create(:excel, user_id: user.id, fees: 12.12)  }

  describe 'Succesfully creates trade from excel data' do
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

    it 'returns a 200 response status' do
      expect(response_json["fees"]).to eq -14.31
    end
  end

  describe 'Succesfully saves trade data from excel data' do
    before do
      patch "/api/v1/excels/#{excel2.id}",
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

    it 'returns a 200 response status' do
      expect(response_json["data"][0]["Ticker"]).to eq "AMC"
    end
  end
end