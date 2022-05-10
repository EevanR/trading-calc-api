class Api::V1::SubscriptionsController < ApplicationController
  before_action :authenticate_current_user
  rescue_from Stripe::InvalidRequestError, with: :invalid_token_id
  
  def create
  end
end
