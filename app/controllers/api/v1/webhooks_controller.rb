class Api::V1::WebhooksController < ApplicationController

  def create
    webhook_secret = Rails.application.credentials.stripe_webhook_secret
    payload = request.body.read
    
    if !webhook_secret.blank? && !webhook_secret.nil?
      sig_header = request.env['HTTP_STRIPE_SIGNATURE']
      event = nil
      begin
        event = Stripe::Webhook.construct_event(
          payload, sig_header, webhook_secret
        )
      rescue JSON::ParserError => e
        render json: { errors: "JSON parse error" }, status: 400
      rescue Stripe::SignatureVerificationError => e
        render json: { errors: "⚠️  Webhook signature verification failed." }, status: 400
        return
      end
    else
      data = JSON.parse(payload, symbolize_names: true)
      event = Stripe::Event.construct_from(data)
    end
    event_type = event['type']
    data_object = event.data['object']
    
    if event.type === "invoice.payment_succeeded" && data_object['paid'] === true
      session = StripeSession.find_by(customer_id: data_object.customer)
      if session != nil
        session.status = "paid"
        session.save

        session.persisted? && session.user.role = 1
        session.user.save
      end
    end

    if event.type == 'customer.subscription.deleted' && data_object.status === "canceled"
      user = User.find_by(customer_id: data_object.customer)
      user.role = 0
      user.save
    end

    render json: { message: "Webhook received - #{event_type}" }, status: 200
  end
end