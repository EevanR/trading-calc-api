class Api::V1::SetupsController < ApplicationController
  before_action :authenticate_user!

  def create
    setup = Setup.create(setup_params)
    if setup.persisted?
      render json: setup
    else
      render json: { errors: setup.errors.full_messages }, status: 422
    end
  end

  def destroy
  end

  def index
    binding.pry
  end

  def show
  end

  def update

  end

  private 
  
  def setup_params
    params.require(:setup).permit(:name, :reqOne, :reqTwo, :reqThree, :reqFour, :reqFive, :reqSix, :reqSeven, :reqEight, :reqNine, :reqTen)
  end
end
