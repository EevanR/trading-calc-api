class Api::V1::StripePortalsController < ApplicationController
  before_action :authenticate_user!

  def create
    return_url = 'http://localhost:3001/panes'

    if params['session_id']
      session = StripeSession.find_by(session_id: params['session_id'])
      session.user.customer_id === current_user.customer_id
      user = session.user
    else
      user = current_user
    end

    session = Stripe::BillingPortal::Session.create({
      customer: user.customer_id,
      return_url: return_url
    })
    
    render json: session.url, status: 200
  end
end
