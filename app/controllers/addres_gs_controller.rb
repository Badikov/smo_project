# encoding: utf-8
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
    respond_to do |format|
      if @addres_g.update_attributes(params[:addres_g])
        @addres_g.person.op.update_attributes({tip_op: "П040"})
        format.html { redirect_to home_path, notice: 'Новый адрес регистрации успешно сохранился.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
      end
    end
  end
end
