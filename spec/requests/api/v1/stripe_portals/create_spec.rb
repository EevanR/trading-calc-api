RSpec.describe 'User can create Stripe portal session' do
  let(:user) { create(:user, customer_id: "cus_01234") }
  let(:user_credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(user_credentials) }

  describe 'when user is signed in' do
    before do
      post '/api/v1/stripe_portals',
      params: {
        session_id: "cs_test_a1hBO4UmcEyVUEeuZLy1kOJ1MZoyZFn33byQSNjeqZEWpxohzBkS661a8G"
      },
      headers: headers
    end

    it 'returns unsuccessful response' do
      expect(response).to have_http_status 401
    end

  end
end 