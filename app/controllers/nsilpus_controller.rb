class NsilpusController < ApplicationController
  
  def index
    @lpus = Nsilpu.lpus_of_ate(params[:kdate])
    
    respond_to do |format|
       format.html # show.html.erb
       format.json { render json: @lpus }
    end
  end
end
