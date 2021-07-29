class Api::V1::SetupsController < ApplicationController
  before_action :authenticate_user!

  def create
    setup = Setup.create(setup_params.merge(user_id: current_user.id))
    if setup.persisted?
      render json: setup
    else
      render json: { errors: setup.errors.full_messages }, status: 422
    end
  end

  def destroy
    setup = Setup.find(params[:id])
    if setup.user_id === current_user.id
      setup.destroy
      render json: { message: "Setup Deleted" }
    else
      render json: { errors: ["You are not authorized for this action."] }, status: 401
    end
  end

  def index
    setups = Setup.where(user_id: current_user.id)
    render json: setups
  end

  def show
    setup = Setup.find(params[:id])
    if setup.user_id === current_user.id
      render json: setup
    else
      render json: { errors: ["You may not view this data"]}, status: 401
    end
  end

  def update
    setup = Setup.find(params[:id])
    setup.update(update_params)
    if setup.persisted? 
      render json: setup
    else
      render json: { error: setup.errors.full_messages }, status: 422
    end
  end

  private 
  
  def setup_params
    params.require(:setup).permit(:name, :req1, :req2, :req3, :req4, :req5, :req6, :req7, :req8, :req9, :req10, :user_id)
  end

  def update_params
    params.permit(:name, :req1, :req2, :req3, :req4, :req5, :req6, :req7, :req8, :req9, :req10, :id)
  end
end
