class Api::V1::Admin::ExcelsController < ApplicationController
  before_action :authenticate_user!

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
end
