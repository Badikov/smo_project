# encoding: utf-8
class AddresPsController < ApplicationController
  # GET /addres_ps/1/edit
  def edit
    @addres_p = AddresP.find_by_person_id(params[:id])
  end
  # PUT /addres_ps/1
  def update
    @addres_p = AddresP.find(params[:id])
    @addres_p.attributes = params[:addres_p]
    
    @addres_p.person.op.touch if params["touch"] == "1"
    if @addres_p.save
       redirect_to home_path, notice: "Поправки успешно сохранены.Тип операции не менялся.#{ params['touch'] == '1' ? 'Запись уйдет в ТерФОМС' : '' }" 
     else
       render action: "edit" 
    end
  end
end
