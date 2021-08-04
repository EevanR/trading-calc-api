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

  describe "unsuccessfully show unauthorized tweet" do
  let(:user2) { create(:user, email: "user2@random.com", nickname: "User2") }
  let(:credentials2) { user2.create_new_auth_token }
  let!(:headers2) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials2) }
  let(:tweet2) { create(:tweet, name: "vanniferarri", user_id: user2.id)  }

    before do
      get "/api/v1/tweets/#{tweet.id}",
      headers: headers2
    end

    it "returns a 401 response status" do
      expect(response).to have_http_status 401
    end
  end
end