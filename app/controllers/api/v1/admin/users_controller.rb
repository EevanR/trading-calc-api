class Api::V1::Admin::UsersController < ApplicationController
  before_action :authenticate_user!

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
    user = User.find(params[:id])
    render json: user
  end

  private

  def update_params
    params.permit(:risk)
  end
end