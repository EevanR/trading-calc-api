class Api::V1::ExcelsController < ApplicationController
  before_action :authenticate_user!

  def create
    entry = Excel.create(excels_params)
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

  def excels_params
    params.require(:excel).permit(:user_id, data: [])
  end

end