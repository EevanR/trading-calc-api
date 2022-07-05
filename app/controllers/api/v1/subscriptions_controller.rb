class Api::V1::SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    Stripe.api_key = Rails.application.credentials.stripe[:secret_key]

    customer = Stripe::Customer.create(
      email: current_user.email,
    )
    
    prices = Stripe::Price.list(
      lookup_keys: [params['lookup_key']],
      expand: ['data.product']
    )

    session = Stripe::Checkout::Session.create({
      mode: 'subscription',
      customer: customer.id,
      line_items: [{
        quantity: 1,
        price: prices.data[0].id
      }],
      success_url: 'https://www.trade-logs.com/receipt' + '?success=true&session_id={CHECKOUT_SESSION_ID}',
      cancel_url: 'https://www.trade-logs.com/receipt' + '?canceled=true',
    })
    user = current_user
    user.customer_id = session.customer
    user.stripe_sessions.create(session_id: session.id, customer_id: session.customer)
    user.save
    
    render json: session
  end
end