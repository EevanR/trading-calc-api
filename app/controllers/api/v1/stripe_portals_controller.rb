class Api::V1::StripePortalsController < ApplicationController
  before_action :authenticate_user!

  def create
    session = StripeSession.find_by(session_id: params['session_id'])
    user = session.user
    return_url = 'http://localhost:3001/panes'

    if user.customer_id === current_user.customer_id
      binding.pry
      session = Stripe::BillingPortal::Session.create({
                                                        customer: user.customer_id,
                                                        return_url: return_url
                                                      })
      # render json: session, status: 200
      
      redirect_to session.url, status: 303
    else
      render json: { errors: "Not Authorized" }, status: 401
    end
  end
end
