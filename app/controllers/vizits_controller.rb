# encoding: utf-8
class VizitsController < ApplicationController
  def new
    @person = Person.find(params[:id])
    @vizit = Vizit.new
  end
  # GET /vizits/1
  # GET /vizits/1.json
  def show
    vizit = Vizit.find_by_id(params[:id])
    @person = vizit.person
 
    respond_to do |format|
      format.html # show.html.erb
      # format.json { render json: @vizit }
    end
  end
  def index
    statuses =[]
    file = File.open( 'person_.txt' )
    i = 0
      file.each do |line|
      if  i == 1
        str = line.delete("null")
	
	  przcod,id_fl,tip_op,status,fam,im,ot,w,dr,kod,ss,phone,email,fiopr,contact,ddeath,doctype,docser,docnum,docdate,name_vp,
	  mr,bomg,kod_tf,indx,okato,npname,ul,dom,korp,kv,dreg,dvizit,method,petition,rsmo,rpolis,fpolis,ter_st,ogrnsmo,enp,erp,vpolis,
	  spolis,npolis,dbeg,dend,dstop,datepolis,date_modif = str.chomp("\n").split("\t")
        
          statuses << [przcod,id_fl,tip_op,status,fam,im,ot,w,dr,kod,ss,phone,email,fiopr,contact,ddeath,doctype,docser,docnum,docdate,name_vp,
	  mr,bomg,kod_tf,indx,okato,npname,ul,dom,korp,kv,dreg,dvizit,method,petition,rsmo,rpolis,fpolis,ter_st,ogrnsmo,enp,erp,vpolis,
	  spolis,npolis,dbeg,dend,dstop,datepolis,date_modif]
      end
        i = i+1 
      end
    file.close
    render json: statuses
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
    vizit = params[:vizit]
    vizit[:insurance_attributes][:ter_st] = "32000"
    vizit[:insurance_attributes][:ogrnsmo] = "1042201923720"
    
    
    if vizit[:petition]
      
    end
    #:TODO Обработать событие Petition---> dvizit==nil, method==nil, rsmo==nil
    tmp = Date.strptime("{#{ vizit['dvizit(1i)']}, #{ vizit['dvizit(2i)']}, #{ vizit['dvizit(3i)']} }", "{ %Y, %m, %d }")
# 	
    tip_op = ""
    event_logic(vizit,tip_op)
    
    
    if tip_op != ""
      if vizit[:insurance_attributes][:polis_attributes][:vpolis] == ""
	      vizit[:insurance_attributes].delete(:polis_attributes)
      end 
      
      vizit.delete(:rpolis) if vizit[:rpolis] == ""
      
      @vizit = Vizit.create(vizit)
      
      if @vizit.save 
	      @op = Op.find_by_person_id(vizit[:person_id])
  
	      @op.update_attributes({ id: @op.person_id, tip_op: tip_op, user_id: @current_user })
  
	      redirect_to @vizit, notice: 'Визит сохранен.'
      else
	      redirect_to action: "new", id: vizit[:person_id]
      end
      
    else
      redirect_to action: "new", id: vizit[:person_id]
#       render json: params
    end
#      @tmp = (params[:vizit][:insurance_attributes][:polis_attributes]['dend(1i)'] + "-" + params[:vizit][:insurance_attributes][:polis_attributes]['dend(2i)'] + "-" + params[:vizit][:insurance_attributes][:polis_attributes]['dend(3i)'])
#     render json: @tmp
 
  end
  def event_logic(vizit,tip_op)
    if (vizit[:rsmo] == '1' and vizit[:fpolis] != '0')
      tip_op = "П010"
      vizit[:insurance_attributes][:polis_attributes][:vpolis] = 2
      insert_dates(vizit, tmp)
      
    elsif (vizit[:rsmo] == '2' and vizit[:fpolis] == '0' and vizit[:insurance_attributes][:enp] != "" and vizit[:rpolis] == "")
      tip_op = "П031"
      
    elsif (vizit[:rsmo] == '3' and vizit[:fpolis] == '0' and vizit[:insurance_attributes][:enp] != "" and vizit[:rpolis] == "")
      tip_op = "П032"
      
    elsif (vizit[:rsmo] == '4' and vizit[:fpolis] == '0' and vizit[:insurance_attributes][:enp] != "" and vizit[:rpolis] == "")
      tip_op = "П033"
      
#       params[:vizit][:insurance_attributes][:polis_attributes][:vpolis] = 3 #!!!!оставляю запись Polis - null для 031,032,033
    elsif (vizit[:rsmo] == '2' and vizit[:fpolis] != '0' and vizit[:rpolis] != "")
      tip_op = "П034"
      vizit[:insurance_attributes][:polis_attributes][:vpolis] = 2
      insert_dates(vizit, tmp)
      
    elsif (vizit[:rsmo] == '3' and vizit[:fpolis] != '0' and vizit[:rpolis] != "")
      tip_op = "П035"
      vizit[:insurance_attributes][:polis_attributes][:vpolis] = 2
      insert_dates(vizit, tmp)
      
    elsif (vizit[:rsmo] == '4' and vizit[:fpolis] != '0' and vizit[:rpolis] != "")
      tip_op = "П036"
      vizit[:insurance_attributes][:polis_attributes][:vpolis] = 2
      insert_dates(vizit, tmp)
      
    end
  end
  
  # вставляет дату бегин и дату енд в параметры инсерта
  def insert_dates(vizit, tmp)
    vizit[:insurance_attributes][:polis_attributes]['dbeg(1i)'] = tmp.year.to_s
    vizit[:insurance_attributes][:polis_attributes]['dbeg(2i)'] = tmp.month.to_s
    vizit[:insurance_attributes][:polis_attributes]['dbeg(3i)'] = tmp.day.to_s
    tmp = tmp + 42
    vizit[:insurance_attributes][:polis_attributes]['dend(1i)'] = tmp.year.to_s
    vizit[:insurance_attributes][:polis_attributes]['dend(2i)'] = tmp.month.to_s
    vizit[:insurance_attributes][:polis_attributes]['dend(3i)'] = tmp.day.to_s
  end
  def print_polis
    vizit = Vizit.find_by_id(params[:id])
    @person = vizit.person
    render :partial => "print_polis", :layout => false
  end
  def print_petition
    vizit = Vizit.find_by_id(params[:id])
    @person = vizit.person
    render :partial => "print_petition", :layout => false
  end
end
