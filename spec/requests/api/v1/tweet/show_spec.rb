# frozen_string_literal: true

RSpec.describe 'GET /api/v1/tweets/:id', type: :request do
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }
  let(:tweet) { create(:tweet, user_id: user.id)  }

  describe "successfully show tweeter entry" do
    before do
      get "/api/v1/tweets/#{tweet.id}",
      headers: headers
    end

    it "returns a success response status" do
      expect(response).to have_http_status(:success)
    end

    it 'returns "name" equal to "team3dstocks"' do
      expect(response_json["name"]).to eq "team3dstocks"
    end

    it 'user_id of response_json matches user.id' do
      expect(response_json["user_id"]).to eq user.id
    end
  end

end
