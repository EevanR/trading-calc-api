# frozen_string_literal: true

RSpec.describe 'GET /api/v1/excels/:id', type: :request do
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }
  let(:excel) { create(:excel, user_id: user.id) }
  let(:excel2) { create(:excel) }

  describe 'Successfully show entry from excel data' do
    before do
      get "/api/v1/admin/excels/#{excel.id}",
      headers: headers
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns value from data array' do
      expect(response_json['data'][0]['Ticker']).to eq 'AMC'
    end
  end

  describe 'Show full entry when subscriber' do
    before do
      get "/api/v1/admin/excels/#{excel.id}",
      headers: headers
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns not authorized error' do
      expect(response_json["data"].count).to eq 12
    end
  end

  describe 'unsuccessfully show entry when unauthorized' do
    before do
      get "/api/v1/excels/#{excel2.id}",
      headers: headers
    end

    it 'returns a 200 response status' do
      expect(response).to have_http_status 401
    end

    it 'returns value from grossData array' do
      expect(response_json["errors"][0]).to eq "You may not view this data"
    end
  end
end