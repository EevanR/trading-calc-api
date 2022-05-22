class Api::V1::WebhooksController < ApplicationController

  def create
    # Replace this endpoint secret with your endpoint's unique secret
    # If you are testing with the CLI, find the secret by running 'stripe listen'
    # If you are using an endpoint defined with the API or dashboard, look in your webhook settings
    # at https://dashboard.stripe.com/webhooks
    webhook_secret = Rails.application.credentials.stripe[:webhook_secret]
    payload = request.body.read
    binding.pry
    if !webhook_secret.empty?
      sig_header = request.env['HTTP_STRIPE_SIGNATURE']
      event = nil
  
      begin
        event = Stripe::Webhook.construct_event(
          payload, sig_header, webhook_secret
        )
      rescue JSON::ParserError => e
        status 400
        return
      rescue Stripe::SignatureVerificationError => e
        puts '⚠️  Webhook signature verification failed.'
        status 400
        return
      end
    else
      data = JSON.parse(payload, symbolize_names: true)
      event = Stripe::Event.construct_from(data)
    end

    event_type = event['type']
    data = event['data']
    data_object = data['object']
  
    content_type 'application/json'
    {
      status: 'success'
    }.to_json
  end
end
