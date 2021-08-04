class Api::V1::TweetsController < ApplicationController
  before_action :authenticate_user!

  def create
    tweeter = Tweet.create(tweet_params.merge(user_id: current_user.id))
    if tweeter.persisted?
      render json: tweeter
    else 
      render json: { errors: tweeter.errors.full_messages }, status: 422
    end
  end

  def show
    tweet = Tweet.find(params[:id])
    if tweet.user_id === current_user.id
      render json: tweet
    else
      render json: { errors: "Unable to show entry"}, status: 401
    end
  end

  def destroy
  end

  private

  def tweet_params
    params.require(:tweet).permit(:name)
  end

end