# frozen_string_literal: true

class Api::V1::TradesController < ApplicationController
  def index
  end

  def create
    trade = Trade.create(trade_params)

    if trade.persisted?
      render json: trade
    else
      render json: { error: trade.errors.full_messages }, status: 422
    end
  end

  private

  def trade_params
    params.require(:trade).permit(:ticker, :entry, :shares, :stop, :setup, :date, :profit, :trade_id)
  end
end
