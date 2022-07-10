class Api::V1::Admin::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def update
    user = User.find(params[:id])
    user.update(update_params)
    if user.persisted? 
      render json: user, status: 200
    else
      render json: { error: user.errors.full_messages }, status: 422
    end
  end

  def show
    if params[:id].slice(0,3) === "ses"
      session = params[:id].slice(4, params[:id].length)     
      user = StripeSession.find_by(session_id: session).user
      render json: user
    else
      user = User.find(params[:id])
      if current_user.present? 
        current_user.id === user.id ? (render json: user) : (render json: { error: "Not Authorized" }, status: 401)
      else
        render json: { error: "Must log in to view user data" }, status: 401
      end
    end
  end

  private

  def update_params
    params.permit(:risk)
  end
end