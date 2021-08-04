class Api::V1::TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def create
    tweeter = Tweet.create(tweet_params.merge(user_id: current_user.id))
    if tweeter.persisted?
      render json: tweeter
    else 
      render json: { errors: tweeter.errors.full_messages }, status: 422
    end
  end

  def show
  end

  def destroy
  end

  private

  def tweet_params
    params.require(:tweet).permit(:name)
  end

end
