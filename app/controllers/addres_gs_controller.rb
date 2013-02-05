# encoding: utf-8
class AddresGsController < ApplicationController
  # GET /addres_gs/1/edit
  def edit
    @addres_g = AddresG.find(params[:id])
  end
  # PUT /addres_gs/1
  def update
    @addres_g = AddresG.find(params[:id])
    @addres_g.attributes = params[:addres_g]
    
    @addres_g.person.op.touch if params["touch"] == "1"
    if @addres_g.save
       redirect_to home_path, notice: "Поправки успешно сохранены.Тип операции не менялся.#{ params['touch'] == '1' ? 'Запись уйдет в ТерФОМС' : '' }" 
     else
       render action: "edit" 
    end
  end
  # GET /addres_g/1
  def newaddres_g
    @addres_g = AddresG.find_by_id(params[:id])
    render :layout => false
  end
  # PUT /addres_g/1
  # PUT /addres_g/1.json
  def new_addres_g
    @addres_g = AddresG.find_by_id(params[:id])    
    if @addres_g.update_attributes(params[:addres_g])
        @addres_g.person.op.touch
        @addres_g.person.op.update_attributes({tip_op: "П040"})
        redirect_to home_path, notice: 'Новый адрес регистрации успешно сохранился.' 
    else
        render action: "newaddres_g"
    end
  end
end
