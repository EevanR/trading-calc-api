# frozen_string_literal: true

RSpec.describe 'DELETE /api/v1/tweets/:id', type: :request do
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }
  let(:tweet) { create(:tweet, user_id: user.id)  }

  let(:user2) { create(:user, email: "guestuser@mail.com", nickname: "Guest") }
  let(:credentials2) { user2.create_new_auth_token }
  let!(:headers2) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials2) }
  let!(:tweet2) { create(:tweet, user_id: user2.id)  }

  describe 'Successfully delete setup' do
    before do
      delete "/api/v1/tweets/#{tweet.id}",
      headers: headers
    end
    
    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it "setup count should equal 1" do
      expect(Tweet.count).to eq 1
    end
  end

  describe 'Unsuccessfully delete tweet as non authorized user' do
    before do
      delete "/api/v1/tweets/#{tweet.id}",
      headers: headers2
    end
    
    it 'returns a 401 response status' do
      expect(response).to have_http_status 401
    end

    it "Tweet count should equal 2" do
      expect(Tweet.count).to eq 2
    end
  end
end