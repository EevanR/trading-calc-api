# frozen_string_literal: true
require 'stripe_mock'
require 'rails_helper'

RSpec.describe 'POST /api/v1/webhooks', type: :request do
  let(:user) { create(:user, role: 'user') }
  let(:credentials) { user.create_new_auth_token }
  let!(:headers2) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }
  let(:stripe_helper) { StripeMock.create_test_helper }
    before(:each) { StripeMock.start }
    after(:each) { StripeMock.stop }

  describe 'payment success webhook' do
    before do
      event = StripeMock.mock_webhook_event('invoice.payment_succeeded')
      headers = {
        "Stripe-Signature": stripe_event_signature(event.to_json)
      }
      post '/api/v1/webhooks', params: event, headers: headers, as: :json
    end

    it "mocks a stripe webhook successfully" do
      expect(response.code).to eq('200')
    end

    it "recieves success payment status" do
      expect(response_json['paid']).to eq('true')
    end
  end

  describe 'Signature webhook fails' do
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

  describe 'invoice status as payment failed' do
    before do
      event = StripeMock.mock_webhook_event('invoice.payment_failed')
      headers = {
        "Stripe-Signature": stripe_event_signature(event.to_json)
      }
      post '/api/v1/webhooks', params: event, headers: headers, as: :json
    end

    it "responds with error code 400" do
      expect(response.code).to eq('400')
    end

    it "responds with failed payment invoice status" do
      expect(response_json['paid']).to eq('false')
    end
  end

  describe 'charge success' do
    before do
      event = StripeMock.mock_webhook_event('charge.succeeded')
      headers = {
        "Stripe-Signature": stripe_event_signature(event.to_json)
      }
      post '/api/v1/webhooks', params: event, headers: headers, as: :json
    end

    it "responds with error code 200" do
      expect(response.code).to eq('200')
    end

    it "paid = true status" do
      expect(response_json['paid']).to eq('true')
    end
  end

  describe 'charge failed' do
    before do
      event = StripeMock.mock_webhook_event('charge.failed')
      headers = {
        "Stripe-Signature": stripe_event_signature(event.to_json)
      }
      post '/api/v1/webhooks', params: event, headers: headers, as: :json
    end

    it "responds with error code 400" do
      expect(response.code).to eq('400')
    end

    it "paid = false status" do
      expect(response_json['paid']).to eq('false')
    end
  end

  describe 'customer updates subscription' do
    before do
      event = StripeMock.mock_webhook_event('customer.subscription.updated')
      headers = {
        "Stripe-Signature": stripe_event_signature(event.to_json)
      }
      post '/api/v1/webhooks', params: event, headers: headers, as: :json
    end

    it "responds with error code 200" do
      expect(response.code).to eq('200')
    end

    it "responds with subscription updated message" do
      expect(response_json['message']).to eq('customer.subscription.updated')
    end
  end
end 