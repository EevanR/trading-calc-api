# frozen_string_literal: true

RSpec.describe 'GET /api/v1/excels/:id', type: :request do
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }
  let(:excel) { create(:excel, user_id: user.id) }

  describe 'Succesfully show entry from excel data' do
    before do
      get "/api/v1/excels/#{excel.id}",
      headers: headers

    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns value from grossData array' do
      expect(response_json["netData"][0][0])
    end
  end

end