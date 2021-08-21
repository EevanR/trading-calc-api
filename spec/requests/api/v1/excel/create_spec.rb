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
          user_id: "15",
          data: [
            [-18.879999999999995, 0, 0.4212152777777778, "08/03/2021", "/"],
            [-20, 0, 0.4212152777777778, "08/03/2021", "/"]
          ]
        }
      },
      headers: headers
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns the name of strategy' do
      expect(response_json['user_id']).to eq "15"
    end
  end

end