class OkatosController < ApplicationController
  def index
    @okato = Okato.order(:namenpt).where("namenpt like ?", "%#{params[:term]}%")
#     @ok = Hash.new
#     @ok[:label] = @okato.map(&:namenpt)
#     @ok[:value] = @okato.map(&:okato)
    
    render json: @okato
  end
end
