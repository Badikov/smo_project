# encoding: utf-8
class VizitsController < ApplicationController
  def new
    @person = Person.find(params[:id])
    @vizit = Vizit.new
  end
  # GET /vizits/1
  # GET /vizits/1.json
  def show
    @vizit = Vizit.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @vizit }
    end
  end
  def index
#       file = File.open( "Okato" )
#  file.each { |line|  
#    sim = { kdnpt: "", namenpt: "", kdobl: "", kdate: "", okato: "" }
#    st = line
#    st = st.chomp("\n")
#    ar = []
#    ar = st.split("\t") 
#    
#   i = 0
#   sim.each{|k,v| 
# 	  sim[k] = ar[i] 
# 	  i+= 1 }
#    @ok = Okato.create(sim)
#  }
#   
# file.close
#     @ok = Okato.all
#     respond_to do |format|
#       format.html # show.html.erb
#       format.json { render json: @ok }
#     end
  end
  # POST /vizits
  def create
    tmp = Date.strptime("{#{ params[:vizit]['dvizit(1i)']}, #{ params[:vizit]['dvizit(2i)']}, #{ params[:vizit]['dvizit(3i)']} }", "{ %Y, %m, %d }")
# 	
    tip_op = ""
    if (params[:vizit][:rsmo] == '1' and params[:vizit][:fpolis] != '0')
      tip_op = "П010"
      params[:vizit][:insurance_attributes][:polis_attributes][:vpolis] = 2
      insert_dates(params, tmp)
      
    elsif (params[:vizit][:rsmo] == '2' and params[:vizit][:fpolis] == '0' and params[:vizit][:insurance_attributes][:enp] != "" and params[:vizit][:rpolis] == "")
      tip_op = "П031"
      
    elsif (params[:vizit][:rsmo] == '3' and params[:vizit][:fpolis] == '0' and params[:vizit][:insurance_attributes][:enp] != "" and params[:vizit][:rpolis] == "")
      tip_op = "П032"
      
    elsif (params[:vizit][:rsmo] == '4' and params[:vizit][:fpolis] == '0' and params[:vizit][:insurance_attributes][:enp] != "" and params[:vizit][:rpolis] == "")
      tip_op = "П033"
      
#       params[:vizit][:insurance_attributes][:polis_attributes][:vpolis] = 3 #!!!!оставляю запись Polis - null для 031,032,033
    elsif (params[:vizit][:rsmo] == '2' and params[:vizit][:fpolis] != '0' and params[:vizit][:rpolis] != "")
      tip_op = "П034"
      params[:vizit][:insurance_attributes][:polis_attributes][:vpolis] = 2
      insert_dates(params, tmp)
      
    elsif (params[:vizit][:rsmo] == '3' and params[:vizit][:fpolis] != '0' and params[:vizit][:rpolis] != "")
      tip_op = "П035"
      params[:vizit][:insurance_attributes][:polis_attributes][:vpolis] = 2
      insert_dates(params, tmp)
      
    elsif (params[:vizit][:rsmo] == '4' and params[:vizit][:fpolis] != '0' and params[:vizit][:rpolis] != "")
      tip_op = "П036"
      params[:vizit][:insurance_attributes][:polis_attributes][:vpolis] = 2
      insert_dates(params, tmp)
      
    end
    if tip_op != ""
      if params[:vizit][:insurance_attributes][:polis_attributes][:vpolis] == ""
	params[:vizit][:insurance_attributes].delete(:polis_attributes)
      end 
      params[:vizit].delete(:rpolis) if params[:vizit][:rpolis] == ""
      
      @vizit = Vizit.create(params[:vizit])
      
      if @vizit.save 
	@op = Op.find_by_person_id(params[:vizit][:person_id])
	@op.update_attributes({ tip_op: tip_op, user_id: current_user })
	redirect_to @vizit, notice: 'Визит сохранен.'
      else
	redirect_to action: "new", id: params[:vizit][:person_id]
      end
    else
      redirect_to action: "new", id: params[:vizit][:person_id]
#       render json: params
    end
#      @tmp = (params[:vizit][:insurance_attributes][:polis_attributes]['dend(1i)'] + "-" + params[:vizit][:insurance_attributes][:polis_attributes]['dend(2i)'] + "-" + params[:vizit][:insurance_attributes][:polis_attributes]['dend(3i)'])
#     render json: @tmp
    
#     @vizit = Vizit.create(params[:vizit])
    
  end
  # вставляет дату бегин и дату енд в параметры инсерта
  def insert_dates(params, tmp)
    params[:vizit][:insurance_attributes][:polis_attributes]['dbeg(1i)'] = tmp.year.to_s
    params[:vizit][:insurance_attributes][:polis_attributes]['dbeg(2i)'] = tmp.month.to_s
    params[:vizit][:insurance_attributes][:polis_attributes]['dbeg(3i)'] = tmp.day.to_s
    tmp = tmp + 42
    params[:vizit][:insurance_attributes][:polis_attributes]['dend(1i)'] = tmp.year.to_s
    params[:vizit][:insurance_attributes][:polis_attributes]['dend(2i)'] = tmp.month.to_s
    params[:vizit][:insurance_attributes][:polis_attributes]['dend(3i)'] = tmp.day.to_s
  end
end
