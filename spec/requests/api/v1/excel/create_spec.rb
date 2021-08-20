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
          user_id: "1",
          Comm: 0.99,
          Currency: "USD",
          ECNAdd: 0,
          ECNRemove: 0,
          ExecTime: 0.412,
          GrossProceeds: 100,
          Liq: "n",
          NSCC: 0.0003,
          Nasdaq: 0.033,
          NetProceeds: 90,
          Price: 10.00,
          Qty: 100,
          SD: "01/03/21",
          SEC: 0.0923,
          Side: "BC",
          Symbol: "AAPL",
          TD: "01/01/21"
        }
      },
      headers: headers
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns the name of strategy' do
      expect(response_json['user_id']).to eq "1"
    end
  end

end