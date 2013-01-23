class AtesController < ApplicationController
  # GET /ates
  # GET /ates.json
  def index
    @ates = Ate.all(:order => 'nameate')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ates }
    end
  end
  # GET /ates/1/edit
  def edit
    @ate = Ate.find(params[:id])
    @nsilpu = Nsilpu.lpus_of_ate(@ate.kdate)
  end
end
