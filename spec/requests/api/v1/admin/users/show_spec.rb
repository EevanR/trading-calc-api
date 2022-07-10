RSpec.describe 'GET /api/v1/admin/users/:id', type: :request do
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let!(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }
  let!(:stripe_session) { create(:stripe_session, user_id: user.id) }

  describe 'show user attributes if still logged in' do
    before do
      get "/api/v1/admin/users/#{user.id}",
      headers: headers
    end
    
    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it "returns correct user" do
      expect(response_json['id']).to eq user.id
    end
  end

  describe 'unable to find user without headers' do
    before do
      get "/api/v1/admin/users/#{user.id}"
    end
    
    it 'returns a 401 response status' do
      expect(response).to have_http_status 401
    end

    it "returns unauthorized message" do
      expect(response_json['error']).to eq "Must log in to view user data"
    end
  end

  describe 'find user by session_id without authentication' do
    before do
      get "/api/v1/admin/users/ses=#{stripe_session.session_id}"
    end
    
    it 'returns a 200 response status' do
      expect(response).to have_http_status 200
    end

    it "returns user of StipeSession" do
      expect(response_json['id']).to eq user.id
    end
  end
end