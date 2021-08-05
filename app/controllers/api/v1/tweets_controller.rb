class Api::V1::TweetsController < ApplicationController
  before_action :authenticate_user!

  def create
    savedHandles = Tweet.all
    if savedHandles === []
      tweeter = Tweet.create(tweet_params.merge(user_id: current_user.id))
      if tweeter.persisted? 
        render json: tweeter
      else
        render json: { errors: tweeter.errors.full_messages }, status: 422
      end
    else
      savedHandles.each do |handle|
        if handle.name === tweet_params['name'] 
          render json: handle 
        else
          tweeter = Tweet.create(tweet_params.merge(user_id: current_user.id))
          if tweeter.persisted? 
            render json: tweeter
          else
            render json: { errors: tweeter.errors.full_messages }, status: 422
          end
        end
      end
    end
  end

  def index
    twitterHandles = Tweet.where(user_id: current_user.id)
    render json: twitterHandles
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
    tweet = Tweet.find(params[:id])
    if tweet.user_id === current_user.id
      tweet.destroy
      render json: { message: "Tweet deleted" }
    else
      render json: { errors: ["You are not authorized for this action."] }, status: 401
    end
  end

  def update
    tweet = Tweet.find(params[:id])
    tweet.update(update_params)
    if tweet.persisted?
      render json: tweet
    else
      render json: { error: tweet.errors.full_messages }, status: 422
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:name)
  end

  def update_params
    params.require(:tweet).permit(:name)
  end
end
