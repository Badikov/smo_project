class AddresGsController < ApplicationController
  
  # GET /addres_g/1/edit
  def edit
    @addres_g = AddresG.find_by_id(params[:id])
    render :layout => false
  end
  # PUT /addres_g/1
  # PUT /addres_g/1.json
  def update
    @addres_g = AddresG.find_by_id(params[:id])    
    # 
    # respond_to do |format|
    #   if @person.update_attributes(params[:person])
    #     format.html { redirect_to @person, notice: 'Person was successfully updated.' }
    #     format.json { head :no_content }
    #   else
    #     format.html { render action: "edit" }
    #   end
    # end
    render json: params
  end
end
