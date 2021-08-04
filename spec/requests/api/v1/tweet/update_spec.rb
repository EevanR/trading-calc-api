RSpec.describe 'PUT /api/v1/tweets', type: :request do
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }
  let!(:tweet) { create(:tweet, user_id: user.id)  }

  describe 'Successfully edits tweeter name' do
    before do
      put "/api/v1/tweets/#{tweet.id}",
      params: {
        tweet: {
          name: "elonmusk"
        }
      },
      headers: headers
    end
    
    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'returns a updated name of "elonmusk"' do
      expect(response_json['name']).to eq "elonmusk"
    end
  end

  describe 'Cannot update unauthorized tweet details' do
    before do
      put "/api/v1/tweets/#{tweet.id}",
      params: {
        tweet: {
          name: "elonmusk"
        }
      }
    end
    
    it 'returns a 401 response status' do
      expect(response).to have_http_status 401
    end

    it 'returns a updated name of "elonmusk"' do
      expect(response_json['errors'][0]).to eq "You need to sign in or sign up before continuing."
    end
  end
end