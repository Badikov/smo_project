# encoding: utf-8
class RepresentativesController < ApplicationController
  before_filter :require_user
  # GET /representatives/1/edit
  def edit
    @representative = Representative.find(params[:id])
  end
  def new
    person = Person.find(params[:id])
    @representative = person.build_representative
  end
  # PUT /representatives/1
  def update
    @representative = Representative.find(params[:id])
    @representative.attributes = params[:representative]
    @representative.person.op.touch if params["touch"] == "1"
    if @representative.save
       redirect_to home_path, notice: "Поправки успешно сохранены.Тип операции не менялся.#{ params['touch'] == '1' ? 'Запись уйдет в ТерФОМС' : '' }" 
     else
       render action: "edit" 
    end
  end
  def create
    @representative = Representative.new(params[:representative])
    if @representative.save
      @representative.person.op.touch
      @representative.person.vizit.politics = false
      @representative.person.vizit.attributes = {method: "2"}
      @representative.person.vizit.save(:validate => false)
      redirect_to home_path, notice: "Представитель успешно добавлен."
    else
      flash[:error] = "Сохранить не получилось, проверьте ошибки в параметрах."
      render :new
    end
  end
end
