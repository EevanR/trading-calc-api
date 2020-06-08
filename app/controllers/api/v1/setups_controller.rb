class Api::V1::SetupsController < ApplicationController
  def create
  end

  def destroy
  end

  def index
  end

  def show
  end

  private 
  
  def trade_params
    params.require(:setup).permit(:name)
  end
end
