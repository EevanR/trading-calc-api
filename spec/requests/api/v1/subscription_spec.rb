require 'stripe_mock'

RSpec.describe 'User can buy subscritption' do
  let(:stripe_helper) { StripeMock.create_test_helper }
    before(:each) { StripeMock.start }
    after(:each) { StripeMock.stop }
  let(:user) { create(:user) }
  let(:user_credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(user_credentials) }

  describe 'with valid stripe token' do
    describe "successfully" do
      before do
        post '/api/v1/subscriptions',
        params: {
          stripeToken: stripe_helper.generate_card_token    
        },
        headers: headers
        user.reload
      end

      it 'with valid stripe token recieve successful response' do
        expect(response).to have_http_status 200
      end

      it 'receives success message' do
        expect(response_json["message"]).to eq 'Transaction cleared'
      end

      it 'has their role updated to subscriber' do
        expect(user.role).to eq 'subscriber'
      end
    end
  end
end 