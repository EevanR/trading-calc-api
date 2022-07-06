class Api::V1::SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    Stripe.api_key = "sk_test_51Ky6crB3yNNgOUzgPjlEhKuD2qr00RstcGAC0nmXWXw5ll8BWp1kRHqqL36O6Ajo5ZPWKSuU4AwW2rR4aS3h87VP00x4vXZqe4"

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