class Api::V1::ExcelsController < ApplicationController
  before_action :authenticate_user!

  def create
    entry = Excel.create(excels_params.merge(user_id: current_user.id))
    if entry.persisted?
      render json: entry
    else
      render json: { errors: entry.errors.full_messages }, status: 422
    end
  end

  def index
    entries = Excel.where(user_id: current_user.id)
    render json: entries
  end

  def show
    entry = Excel.find(params[:id])
    if entry.user_id === current_user.id
      render json: entry
    else
      render json: { errors: ["You may not view this data"]}, status: 401
    end
  end

  def destroy
    entry = Excel.find(params[:id])
    if entry.user_id === current_user.id
      entry.destroy
      render json: { message: "Entry Deleted" }
    else
      render json: { errors: ["You are not authorized for this action."] }, status: 401
    end
  end

  private

  def excels_params
    params.require(:excel).permit(:user_id, data: [:Ticker, :NetProfit, :GrossProfit, :ShareCount, :TimeStamp, :Date, :Commissions])
  end

end