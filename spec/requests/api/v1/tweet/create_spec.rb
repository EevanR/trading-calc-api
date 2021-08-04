# frozen_string_literal: true

RSpec.describe 'POST /api/v1/tweets', type: :request do
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

  describe "successfully creates tweeter entry" do
    before do
      post '/api/v1/tweets',
      params: {
        tweet: {
          name: "team3dstocks"
        }
      },
      headers: headers
    end

    it "returns a success response status" do
      expect(response).to have_http_status(:success)
    end

    it 'returns correct JSON' do
      expect(response_json["name"]).to eq "team3dstocks"
    end

    it 'returns correct JSON matching correct user' do
      expect(response_json["user_id"]).to eq user.id
    end
  end

  describe "fails to create new tweeter entry when not authenticated" do
    before do
      post '/api/v1/tweets',
      params: {
        tweet: {
          name: "team3dstocks"
        }
      }
    end

    it 'returns 401 not authenticated error' do
      expect(response).to have_http_status 401
    end

    it 'returns an error message' do
      expect(response_json['errors'][0]).to eq "You need to sign in or sign up before continuing."
    end
  end

  describe 'fails to create new tweeter entry when name not provided' do
    before do
      post '/api/v1/tweets',
      params: {
        tweet: {
          name: ""
        }
      },
      headers: headers
    end

    it 'returns 422 "unable to process" error' do
      expect(response).to have_http_status 422
    end

    it 'returns an error message' do
      expect(response_json['errors'][0]).to eq "Name can't be blank"
    end

    it 'cannot locate "failed" entry' do
      expect(Tweet.all).to be_empty
    end
  end
end
