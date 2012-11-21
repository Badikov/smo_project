# encoding: utf-8
class VizitsController < ApplicationController
  def new
    @person = Person.find(params[:id])
    @vizit = Vizit.new
  end
  # GET /vizits/1
  # GET /vizits/1.json
  def show
    # (10...566).each do |n| 
    #   @person = Person.find_by_id(n)
    #   @person.destroy
    #   
    # end
    # render json: status
    vizit = Vizit.find_by_id(params[:id])
    @person = vizit.person
    
    respond_to do |format|
      format.html # show.html.erb
      # format.json { render json: @vizit }
    end
  end
  # DELETE /vizits/1
  # DELETE /people/1.json 566
  def destroy
    
  end
  def index
    statuses =[]
    s_oksm = ""
    file = File.open("people_.txt")
    i = 0
      file.each do |line|
	
	if  i > 0
	  str = line.delete("null")
	  przcod,id_fl,tip_op,status,fam,im,ot,w,dr,kod,ss,phone,email,fiopr,parents,contact,ddeath,doctype,docser,docnum,
	      docdate,name_vp,mr,bomg,kod_tf,indx,okato,npname,ul,dom,korp,kv,dreg,dvizit,method,petition,rsmo,rpolis,fpolis,
	      ter_st,ogrnsmo,enp,erp,vpolis,spolis,npolis,dbeg,dend,dstop,date_modif = str.chomp("\n").split("\t")
	  s_oksm= Oksm.select("distinct alfa3").where(:kod =>  kod).map(&:alfa3)
	  user_id = cod_podrazdeleniy(przcod)
	  ss = ss.empty? ? nil : ss
	  fiopr = fiopr.empty? ? nil : fiopr
	  contact = contact.empty? ? nil : contact
	  dr = dr.empty? ? nil : dr.to_date
	  ddeath = ddeath.empty? ? nil : ddeath.to_date
	  docdate =docdate.empty? ? nil : docdate.to_date
	  dreg = dreg.empty? ? nil : dreg.to_date
	  dvizit = dvizit.empty? ? nil : dvizit.to_date
	  dbeg = dbeg.empty? ? nil : dbeg.to_date
	  dend = dend.empty? ? nil : dend.to_date
	  dstop = dstop.empty? ? nil : dstop.to_date
	  date_modif = date_modif.empty? ? nil : date_modif.to_date
	  name_or = name_vp.upcase
	  subj = Subekti.select("distinct kod_okato").where(:kod_tf => kod_tf).map(&:kod_okato)
	  korp = korp.empty? ? nil : korp
	  kv = kv.empty? ? nil : kv
	  enp = enp.empty? ? nil : enp
	  spolis = spolis.empty? ? nil : spolis
	  npolis = npolis.empty? ? nil : npolis
	  method = method.empty? ? nil : method.to_i
	  @person = Person.new({status: status,fam: fam, im: im, ot: ot, w: w, dr: dr, true_dr: 1, c_oksm: s_oksm[0], ss: ss,phone: phone,
	                        email: email, fiopr: fiopr, contact: contact, ddeath: ddeath})
	  @person.build_doc({doctype: doctype, docser: docser, docnum: docnum, docdate: docdate, name_vp: name_or, mr: mr})
	  @person.build_addres_g({bomg: bomg, subj: subj[0], indx: indx, okato: okato, npname: npname, ul: ul, dom: dom, korp: korp, kv: kv,dreg: dreg})
	  @person.build_addres_p()
	  @person.build_op({id: id_fl, tip_op: tip_op, user_id: user_id})
	  @person.build_vizit({dvizit: dvizit, method: method, petition: petition.to_i, rsmo: rsmo, rpolis: rpolis, fpolis: fpolis})
	  @person.vizit.build_insurance({ter_st: ter_st, ogrnsmo: ogrnsmo, enp: enp, erp: erp})
	  @person.vizit.insurance.build_polis({vpolis: vpolis, spolis: spolis, npolis: npolis, dbeg: dbeg, dend: dend, dstop: dstop})
# 	  @person.save
	end
        i = i+1 
      end
    file.close
    render json: status
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
  def cod_podrazdeleniy(str)
    case str
      when  "001"
	res = 2
      when  "002"
	res = 3
      when  "003"
	res = 4
      when  "004"
	res = 5
      when  "008"
	res = 6
      when  "009"
	res = 7
      when  "011"
	res = 8
      when  "012"
	res = 9
	when  "013"
	res = 10
    end
    return res
  end
  # POST /vizits
  def create
    vizit = params[:vizit]
    vizit[:insurance_attributes][:ter_st] = "32000"
    vizit[:insurance_attributes][:ogrnsmo] = "1042201923720"
    date_stop = Doc.select("ig_enddate").where(:person_id => vizit[:person_id]).map(&:ig_enddate)
    if !date_stop.nil?
      vizit[:insurance_attributes][:polis_attributes][:dstop] = date_stop
    end
    
    vizit[:dvizit] = vizit[:dvizit].nil? ? DateTime.now : vizit[:dvizit].to_date
    
    
    if vizit[:petition]
      
    end
    #:TODO Обработать событие Petition---> dvizit==nil, method==nil, rsmo==nil
    # tmp = Date.strptime("{#{ vizit['dvizit(1i)']}, #{ vizit['dvizit(2i)']}, #{ vizit['dvizit(3i)']} }", "{ %Y, %m, %d }")
# 	
    tip_op = ""
    event_logic(vizit,tip_op)
    
    
    # if tip_op != ""
    #   # if vizit[:insurance_attributes][:polis_attributes][:vpolis] == ""
	   #   #  vizit[:insurance_attributes].delete(:polis_attributes)
    #   # end 
    #   
    #   vizit.delete(:rpolis) if vizit[:rpolis] == ""
    #   @vizit = Vizit.create(vizit)
    #   
    #   # if @vizit.save 
	   #   #  @op = Op.find_by_person_id(vizit[:person_id])
    #   # 
	   #   #  @op.update_attributes({ id: @op.person_id, tip_op: tip_op, user_id: @current_user })
    #   # 
	   #   #  redirect_to @vizit, notice: 'Визит сохранен.'
    #   # else
	   #   #  redirect_to action: "new", id: vizit[:person_id]
    #   # end
    #   
    # else
    #   # redirect_to action: "new", id: vizit[:person_id]
    #   render json: vizit
    # end

    render json: vizit[:dvizit]
 
  end
  def event_logic(vizit,tip_op)
    if (vizit[:rsmo] == '1' and vizit[:fpolis] != '0' and vizit[:insurance_attributes][:enp] == "" and vizit[:insurance_attributes][:erp] == 0)
      tip_op = "П010"
      vizit[:insurance_attributes][:polis_attributes][:vpolis] = 2
      
      
    elsif (vizit[:rsmo] == '2' and vizit[:fpolis] == '0' and vizit[:insurance_attributes][:enp] != "" and vizit[:insurance_attributes][:erp] == 1 and vizit[:rpolis] == "")
      tip_op = "П031"
      vizit[:insurance_attributes][:polis_attributes][:vpolis] = 3
    elsif (vizit[:rsmo] == '3' and vizit[:fpolis] == '0' and vizit[:insurance_attributes][:enp] != "" and vizit[:insurance_attributes][:erp] == 1 and vizit[:rpolis] == "")
      tip_op = "П032"
      vizit[:insurance_attributes][:polis_attributes][:vpolis] = 3
    elsif (vizit[:rsmo] == '4' and vizit[:fpolis] == '0' and vizit[:insurance_attributes][:enp] != "" and vizit[:insurance_attributes][:erp] == 1 and vizit[:rpolis] == "")
      tip_op = "П033"
      vizit[:insurance_attributes][:polis_attributes][:vpolis] = 3
#       vizit[:insurance_attributes][:polis_attributes][:vpolis] = 3 #!!!!
    elsif (vizit[:rsmo] == '2' and vizit[:fpolis] != '0' and vizit[:rpolis] != "")
      tip_op = "П034"
      vizit[:insurance_attributes][:polis_attributes][:vpolis] = 2 # или 3 --- черт его знает?
      
      
    elsif (vizit[:rsmo] == '3' and vizit[:fpolis] != '0' and vizit[:rpolis] != "")
      tip_op = "П035"
      vizit[:insurance_attributes][:polis_attributes][:vpolis] = 2 # или 3 --- черт его знает?
      
      
    elsif (vizit[:rsmo] == '4' and vizit[:fpolis] != '0' and vizit[:rpolis] != "")
      tip_op = "П036"
      vizit[:insurance_attributes][:polis_attributes][:vpolis] = 2 # или 3 --- черт его знает?
      
      
    end
  end
  
  
  def print_polis
    vizit = Vizit.find_by_id(params[:id])
    @person = vizit.person
    render :partial => "print_polis", :layout => false
  end
  def print_petition
    #TODO: http://www.delphikingdom.com/padeg_online.asp  --- сервис перевода фамилий в родительный падеж
    vizit = Vizit.find_by_id(params[:id])
    @person = vizit.person
    render :partial => "print_petition", :layout => false
  end
end
