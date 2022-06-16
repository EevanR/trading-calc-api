class Api::V1::StripePortalsController < ApplicationController

  def create
    session = StripeSession.find_by(session_id: params['session_id'])
    user = session.user
    return_url = 'http://localhost:3001/panes'

    session = Stripe::BillingPortal::Session.create({
                                                      customer: user.customer_id,
                                                      return_url: return_url
                                                    })
    render json: session, status: 200
  end
end
