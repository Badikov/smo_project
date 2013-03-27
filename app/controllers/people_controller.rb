# encoding: utf-8
class PeopleController < ApplicationController
  
  before_filter :require_user
  # GET /people
  # GET /people.json
  def index
    # @people = Person.all
    @search = Person.search(params[:q])
    @people = @search.result

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @people }
    end
  end

  # GET /people/1
  # GET /people/1.json
  def show
    @person = Person.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @person }
    end
  end

  # GET /people/new
  # GET /people/new.json
  def new
    @person = Person.new
    @person.build_doc
    @person.build_foreigner
    @person.build_addres_g
    @person.build_addres_p
    @person.build_representative
    # 
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @person }
    end
  end

  # GET /people/1/edit
  def edit
    @person = Person.find(params[:id])
  end

  # POST /people
  # POST /people.json
  def create
    
    @person = Person.new(params[:person])
    
    if @person.valid?
      
      @person.build_op({user_id: current_user.id, filial_id: current_user.filial_id, active: 0})
      
      @person.representative.mark_for_destruction  if @person.representative.fam.blank?
      @person.addres_p.mark_for_destruction  if @person.addres_p.npname.blank?
      @person.foreigner.mark_for_destruction  if @person.foreigner.ig_docdate.blank?
        
      
      if @person.save(:validate => false)
        redirect_to  new_vizit_person_url(@person), notice: @person.fam + ' ' + @person.im + ' ' + @person.ot + ' добавлен(а) в базу.'
      else
        flash[:error] = "В программе произошла серьезная ошибка. Обратитесь к администратору."
        render :new
      end
    else
      flash[:error] = "Сохранить не получилось, проверьте ошибки в параметрах."
      render :new
    end
    # require "net/http"
    # str_guid = Net::HTTP.get(URI.parse(URI.encode("http://mozilla.pettay.fi/cgi-bin/mozuuid.pl")))
        
#     @person.update_attributes(params[:person].except(:admin))!!кроме :admin, что бы не удалять :predstavitel
  end

  # PUT /people/1
  # PUT /people/1.json
  def update
    @person = Person.find(params[:id])
    @person.attributes = params[:person]
    @person.politics = false
    @person.op.touch if params["touch"] == "1"
     if @person.save
        redirect_to home_path, notice: "Поправки успешно сохранены.Тип операции не менялся.#{ params['touch'] == '1' ? 'Запись уйдет в ТерФОМС' : '' }" 
     else
        render action: "edit" 
     end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person = Person.find(params[:id])
    @person.destroy

    respond_to do |format|
      format.html { redirect_to people_url }
      format.json { head :no_content }
    end
  end
  #GET  /people/newfam?id=
  def newfam
    @person =Person.find_by_id(params[:id])
    @polis = Polis.new
    @polis.dstop = @person.foreigner.ig_enddate if @person.foreigner
    render :layout => false
  end
  
  # POST /people/newfam
  def new_fam
    @person = Person.find(params[:person][:id])
    @polis = Polis.new(params[:polis])
    if @polis.valid?
      if @person.update_attributes(params[:person])
        
        @vizit = @person.vizit
        @vizit.destroy
        #TODO----в роле method представитель вставляется не совсем правильно....фактически берется старое значение, но оно могло и измениться
        @vizit = @person.build_vizit({method: @person.representative.nil? ? "1" : "2", petition:"0", fpolis:1, rpolis:params[:vizit][:rpolis]})
        @vizit.build_insurance({erp: 1})
        @vizit.insurance.build_polis(params[:polis])
        if @person.foreigner
          if @person.foreigner.ig_doctype.length > 20
            @vizit.insurance.polis.dstop = @person.foreigner.ig_enddate
          end
        end
        if @vizit.save(:validate => false) 
          @vizit.person.op.update_attributes({ tip_op: "П061", user_id: current_user.id, filial_id: current_user.filial_id })
          # render json: params[:person]
          redirect_to @person, notice: 'Новые данные успешно сохранены.'
        else
          flash[:error] = "В программе произошла серьезная ошибка. Обратитесь к администратору."
          render :newfam
        end
      else
        flash[:error] = "В программе произошла серьезная ошибка. Обратитесь к администратору."
        render :newfam
      end
    else
      flash[:error] = "Сохранить не получилось, проверьте ошибки в параметрах."
      render :newfam
    end
  end
  
  def checking
    @person = Person.new(params[:person])
    person = Person.where("fam=\"#{@person.fam}\" and im=\"#{@person.im}\" and ot=\"#{@person.ot}\" and dr=\"#{@person.dr}\"")
    render json: person , :nothing => true
  end
  
  
  #GET  /people/search
  # def search
#     
#   end
#   #GET  /people/result
#   def result
#     @q = Person.search(params[:q])
#     @people = @q.result
#     # if (params[:fam] != "" and params[:im] == "" and params[:ot] == "") then
# # #       @responce = Person.where("fam = :fam AND im = :im AND ot = :ot", {:fam => params[:fam], :im => params[:im], :ot => params[:ot]})
# #       @responce = Person.where("fam = :fam", {:fam => params[:fam]})
# #     else
# #       @responce = 'БАДИКОВ АЮ'
# #     end
#     render action: "search"
# #     redirect_to(search_people_path , @responce)
#   end
end
