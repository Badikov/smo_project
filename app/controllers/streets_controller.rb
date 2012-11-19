class StreetsController < ApplicationController
  def index
    @streets = Street.order(:name).where("name like ?", "%#{params[:term]}%")
    
    render json: @streets.map(&:name)
  end

  def create
  end
end
