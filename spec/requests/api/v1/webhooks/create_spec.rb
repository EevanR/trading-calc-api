# frozen_string_literal: true
require 'stripe_mock'
require 'rails_helper'

RSpec.describe 'POST /api/v1/webhooks', type: :request do
  let(:user) { create(:user, role: 'user') }
  let(:credentials) { user.create_new_auth_token }
  let!(:headers2) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }
  let(:stripe_session) { create(:stripe_session, user_id: user.id) }
  let(:stripe_helper) { StripeMock.create_test_helper }
    before(:each) { StripeMock.start }
    after(:each) { StripeMock.stop }

  describe 'payment success webhook' do
    before do
      event = StripeMock.mock_webhook_event('invoice.payment_succeeded', {
        :id => stripe_session.session_id,
        :customer => stripe_session.customer_id,
        :email => user.email
      })
      headers = {
        "Stripe-Signature": stripe_event_signature(event.to_json)
      }
      post '/api/v1/webhooks', params: event, headers: headers, as: :json
    end

    it "mocks a stripe webhook successfully" do
      expect(response.code).to eq('200')
    end

    it "session status is updated to paid" do
      expect(StripeSession.find(stripe_session.id).status).to eq('paid')
    end

    it "user role is updated to subscriber" do
      expect(User.find(stripe_session.user_id).role).to eq('subscriber')
    end
  end

  describe 'Signature verification fails' do
    before do
      event = StripeMock.mock_webhook_event('invoice.payment_succeeded')
      headers = {
        "Stripe-Signature": ""
      }
      post '/api/v1/webhooks', params: event, headers: headers, as: :json
    end

    it "responds with error code 400" do
      expect(response.code).to eq('400')
    end

    it "responds with failed signature verification message" do
      expect(response_json['errors']).to eq("⚠️  Webhook signature verification failed.")
    end
  end

  describe 'charge failed' do
    before do
      event = StripeMock.mock_webhook_event('charge.failed', {
        :id => stripe_session.session_id,
        :customer => stripe_session.customer_id,
        :email => user.email
      })
      headers = {
        "Stripe-Signature": stripe_event_signature(event.to_json)
      }
      post '/api/v1/webhooks', params: event, headers: headers, as: :json
    end

    it "responds with 200 status code" do
      expect(response.code).to eq('200')
    end

    it "responds with error message" do
      expect(response_json['message']).to eq("Webhook received - charge.failed")
    end

    it "session status is updated to paid" do
      expect(StripeSession.find(stripe_session.id).status).to eq('pending')
    end

    it "user role is updated to subscriber" do
      expect(User.find(stripe_session.user_id).role).to eq('user')
    end
  end
end 