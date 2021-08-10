# frozen_string_literal: true

RSpec.describe 'GET /api/v1/tweets', type: :request do
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }
  let!(:tweet1) { create(:tweet) }
  let!(:tweet) do 
    3.times do
      create(:tweet, name: "team#{rand(1...99)}dstocks", user_id: user.id)
    end
  end

  describe "successfully indexes saved twitter handles" do
    before do
      get '/api/v1/tweets',
      headers: headers
    end

    it "returns a success response status" do
      binding.pry
      expect(response).to have_http_status(:success)
    end

    it 'returns correct JSON' do
      expect(response_json.count).to eq 3
    end

    it 'returns correct entry matching correct user' do
      expect(response_json[0]["user_id"]).to eq user.id
    end
  end
end
