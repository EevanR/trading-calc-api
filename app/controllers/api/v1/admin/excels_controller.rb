class Api::V1::Admin::ExcelsController < ApplicationController
  before_action :authenticate_user!

  def create
    entry = Excel.create(excels_params.merge(user_id: current_user.id))
    authorize(entry)
    if entry.persisted?
      render json: entry
    else
      render json: { errors: entry.errors.full_messages }, status: 422
    end
  end

  def update
    entry = Excel.find(params[:id])
    authorize(entry)
    entry.update(update_params)
    if entry.persisted? 
      render json: entry
    else
      render json: { error: entry.errors.full_messages }, status: 422
    end
  end

  def index
    entries = Excel.where(user_id: current_user.id)
    authorize(entries)
    if entries == []
      entries = nil
      render json: entries
    else
      render json: entries
    end
  end

  private

  def excels_params
    params.require(:excel).permit(:user_id, :fees, data: [:Ticker, :NetProfit, :GrossProfit, :ShareCount, :TimeStamp, :Date, :Commissions])
  end

  def update_params
    params.permit(:user_id, :fees, data: [:Ticker, :NetProfit, :GrossProfit, :ShareCount, :TimeStamp, :Date, :Commissions])
  end
end
