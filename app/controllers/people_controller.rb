# encoding: utf-8
class PeopleController < ApplicationController
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
       # op_attributes[:user_id] = current_user.id
      @person.build_op( :user_id => 1, :active => 0 )
      
      @person.representative.mark_for_destruction  if @person.representative.fam.blank?
      @person.addres_p.mark_for_destruction  if @person.addres_p.npname.blank?
        
      
      if @person.save!
        redirect_to  new_vizit_person_url(@person.id), notice: '#{@person.fam} добавлен(а) в базу.'
      else
        render :new
      end
    else
      render :new
    end
    # require "net/http"
    # str_guid = Net::HTTP.get(URI.parse(URI.encode("http://mozilla.pettay.fi/cgi-bin/mozuuid.pl")))
        
#     @person.update_attributes(params[:person].except(:admin))!!кроме :admin, что бы не удалять :predstavitel
        
    # @person = Person.create(person) 

    # respond_to do |format|
    #   if @person.save
	   #    format.html { redirect_to  new_vizit_person_url(@person.id), notice: 'Новое застрахованное лицо успешно создано.' }
    #   else
    #     format.html { render action: "new" }
    #   end
    # end
  end

  # PUT /people/1
  # PUT /people/1.json
  def update
    @person = Person.find(params[:id])

    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
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
    
    @person =Person.new
    @person.id = params[:id]
    
    render :partial => "newfam", :layout => false
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
