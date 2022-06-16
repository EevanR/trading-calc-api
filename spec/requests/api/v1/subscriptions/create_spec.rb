require 'stripe_mock'

RSpec.describe 'User can buy subscription' do
  let(:stripe_helper) { StripeMock.create_test_helper }
    before(:each) { StripeMock.start }
    after(:each) { StripeMock.stop }
  let(:user) { create(:user, role: "user") }
  let(:user_credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(user_credentials) }

  describe 'when user is not signed in' do
    before do
      post '/api/v1/subscriptions'
    end

    it 'returns unsuccessful response' do
      expect(response).to have_http_status 401
    end

    it 'returns message to sign in or register first' do
      expect(response_json["errors"][0]).to eq 'You need to sign in or sign up before continuing.'
    end
  end
end 