class Api::V1::WebhooksController < ApplicationController

  def create
    webhook_secret = Rails.application.credentials.stripe[:webhook_secret]
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
  
    if event.type.present?
      # binding.pry
      # session = Session.find(event.data.object.id)
      # data_object['paid'] === true ? 
      # render json: { message: "#{event.type}" }, status: 200
    end

    render json: { message: "success" }, status: 200
  end
end