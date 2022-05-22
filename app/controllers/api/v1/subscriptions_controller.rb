class Api::V1::SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  rescue_from Stripe::InvalidRequestError, with: :invalid_token_id
  
  def create
    Stripe.api_key = Rails.application.credentials.stripe[:secret_key]

    prices = Stripe::Price.list(
      lookup_keys: [params['lookup_key']],
      expand: ['data.product']
    )

    session = Stripe::Checkout::Session.create({
      mode: 'subscription',
      line_items: [{
        quantity: 1,
        price: prices.data[0].id
      }],
      success_url: 'http://localhost:3001/panes' + '?success=true&session_id={CHECKOUT_SESSION_ID}',
      cancel_url: 'http://localhost:3001/panes' + '?canceled=true',
    })
    
    render json: session
  end


    # if params[:stripeToken]
    #   customer = Stripe::Customer.create(
    #     email: current_user.email,
    #     source: params[:stripeToken]
    #   )

    #   charge = Stripe::Charge.create(
    #     customer: customer.id,
    #     currency: 'sek',
    #     amount: 999,
    #     description: 'Monthly Subscription'
    #   )
      
    #   if (charge.paid)
    #     current_user.role = 'subscriber'
    #     current_user.save
    #     render json: { message: 'Transaction cleared'}
    #   end
    # else
    #   render json: { message: 'No Stripe token detected'}
    # end

  private

  def invalid_token_id
    render json: { message: 'Transaction rejected, token invalid'}
  end 
end