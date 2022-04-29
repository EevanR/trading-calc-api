class Api::V1::ExcelsController < ApplicationController
  before_action :authenticate_user!

  def create
    entry = Excel.create(excels_params.merge(user_id: current_user.id))
    if entry.persisted?
      entry.data = entry.data.slice(entry.data.length-10,entry.data.length)
      render json: entry
    else
      render json: { errors: entry.errors.full_messages }, status: 422
    end
  end

  def index
    entries = Excel.where(user_id: current_user.id)
    if entries == []
      entries = nil
      render json: entries
    else
      entries[0].data = entries[0].data.slice(entries[0].data.length-10,entries[0].data.length)
      render json: entries
    end
  end

  def destroy
    entry = Excel.find(params[:id])
    if entry.user_id === current_user.id
      entry.destroy
      render json: { message: "Entry Deleted" }, status: 200
    else
      render json: { errors: ["You are not authorized for this action."] }, status: 401
    end
  end

  def update
    entry = Excel.find(params[:id])
    entry.update(update_params)
    if entry.persisted? 
      entry[0].data = entry[0].data.slice(entry[0].data.length-10,entry[0].data.length)
      render json: entry
    else
      render json: { error: entry.errors.full_messages }, status: 422
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