require 'stripe_mock'

RSpec.describe 'User can buy subscritption' do
  let(:stripe_helper) { StripeMock.create_test_helper }
    before(:each) { StripeMock.start }
    after(:each) { StripeMock.stop }
  let(:user) { create(:user, role: "user") }
  let(:user_credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(user_credentials) }

  describe 'with valid stripe token' do
    describe "successfully" do
      # before do
      #   post '/api/v1/subscriptions',
      #   params: {
      #     stripeToken: stripe_helper.generate_card_token    
      #   },
      #   headers: headers
      #   user.reload
      # end

      it "mocks a stripe webhook" do
        event = StripeMock.mock_webhook_event('customer.created')
      
        customer_object = event.data.object
        expect(customer_object.id).to_not be_nil
        expect(customer_object.default_card).to_not be_nil
      end
      
      it "mocks stripe connect webhooks" do
        event = StripeMock.mock_webhook_event('customer.created', account: 'acc_123123')
        expect(event.account).to eq('acc_123123')
      end
    end
  end
end 