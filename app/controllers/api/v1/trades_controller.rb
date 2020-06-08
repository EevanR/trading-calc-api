# frozen_string_literal: true

class Api::V1::TradesController < ApplicationController
  before_action :authenticate_user!

  def index
    trades = Trade.where(user_id: current_user.id)
    render json: trades
  end

  def create
    trade = Trade.create(trade_params.merge(user_id: current_user.id))

    if trade.persisted?
      render json: trade
    else
      render json: { error: trade.errors.full_messages }, status: 422
    end
  end

  def destroy
    Trade.destroy_all
  end

  private

  def trade_params
    params.require(:trade).permit(
      :ticker, 
      :entry, 
      :shares, 
      :stop, 
      :setup, 
      :date, 
      :profit, 
      :trade_id,
      :open,
      :high,
      :low,
      :close,
      :vol,
      :prevClose,
      :volAvg,
      :mktCap,
      :company,
      :industry
    )
  end
end
