class Api::V1::Admin::ExcelsController < ApplicationController
  before_action :authenticate_user!

  def show
    entry = Excel.find(params[:id])
    authorize(entry)
    if entry.user_id === current_user.id
      render json: entry
    else
      render json: { errors: ["You may not view this data"]}, status: 401
    end
  end
end
