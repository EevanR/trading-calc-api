class Api::V1::ExcelsController < ApplicationController
  before_action :authenticate_user!

  def create
    entry = Excel.create(excel_params)
    if entry.persisted?
      render json: entry
    else
      render json: { errors: entry.errors.full_messages }, status: 422
    end
  end

  def index
  end

  def destroy
  end

  private

  def excel_params
    params.require(:excel).permit(:user_id, :Comm, :Currency, :ECNAdd, :ECNRemove, :ExecTime, :GrossProceeds, :Liq, :NSCC, :Nasdaq, :NetProceeds, :Price, :Qty, :Side, :Symbol, :TD, :SD, :SEC)
  end
end
