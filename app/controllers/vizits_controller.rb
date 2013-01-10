# encoding: utf-8
class VizitsController < ApplicationController
  # GET /vizits/new
  # GET /vizits/new.json
  def new
    person = Person.find(params[:id])
    @vizit = person.build_vizit
    @vizit.build_insurance
    @vizit.insurance.build_polis
    @vizit.insurance.polis.dstop = person.doc.ig_enddate
    # @vizit = Vizit.new
  end
  # GET /vizits/1
  # GET /vizits/1.json
  def show
     # 
     # (1..1510).each do |n| 
     #  @person = Person.find_by_id(n)
     #  @person.destroy
     #   
     # end
     # render json: status

     vizit = Vizit.find_by_id(params[:id])
     @person = vizit.person
     
     respond_to do |format|
       format.html # show.html.erb
       format.json { render json: @vizit }
     end
  end
  # DELETE /vizits/1
  # DELETE /people/1.json 566
  def destroy
    
  end
  def index
    statuses =[]
    s_oksm = ""
    file = File.open("p_10.txt")
    i = 0
      file.each do |line|
	
	if  i > 0
	  str = line#.delete("null")
	  przcod,id_fl,tip_op,status,fam,im,ot,w,dr,kod,ss,phone,email,fiopr,parents,contact,ddeath,doctype,docser,docnum,docdate,name_vp,mr,bomg,kod_tf,indx,okato,npname,ul,dom,korp,kv,dreg,dvizit,method,petition,rsmo,rpolis,fpolis,ter_st,ogrnsmo,enp,erp,vpolis,spolis,npolis,dbeg,dend,dstop,date_polis,datepp,date_uvoln,date_modif = str.chomp("\n").split("\t")
	  s_oksm= Oksm.select("distinct alfa3").where(:kod =>  kod).map(&:alfa3)
	  user_id = cod_podrazdeleniy(przcod)
	  ss = ss.empty? ? nil : ss
	  fiopr = fiopr.empty? ? nil : fiopr
	  contact = contact.empty? ? nil : parents + "^" + contact
	  dr = dr.empty? ? nil : dr.to_date
	  ddeath = ddeath.empty? ? nil : ddeath.to_date
	  docdate =docdate.empty? ? nil : docdate.to_date
	  dreg = dreg.empty? ? nil : dreg.to_date
	  dvizit = dvizit.empty? ? nil : dvizit.to_date
	  dbeg = dbeg.empty? ? nil : dbeg.to_date
	  dend = dend.empty? ? nil : dend.to_date
	  dstop = dstop.empty? ? nil : dstop.to_date
	  date_modif = date_modif.empty? ? nil : date_modif.to_date
	  date_polis = date_polis.empty? ? nil : date_polis.to_date
	  datepp = datepp.empty? ? nil : datepp.to_date
	  date_uvoln = date_uvoln.empty? ? nil : date_uvoln.to_date
	  name_or = name_vp.upcase
	  subj = Subekti.select("distinct kod_okato").where(:kod_tf => kod_tf).map(&:kod_okato)
	  korp = korp.empty? ? nil : korp
	  kv = kv.empty? ? nil : kv
	  enp = enp.empty? ? nil : enp
	  spolis = spolis.empty? ? nil : spolis
	  npolis = npolis.empty? ? nil : npolis
	  method = method.empty? ? nil : method.to_i
    active = date_uvoln.nil? ? 1 : 0
	  @person = Person.new({status: status,fam: fam, im: im, ot: ot, w: w, dr: dr, true_dr: 1, c_oksm: s_oksm[0], ss: ss,phone: phone,
	                        email: email, fiopr: fiopr, contact: contact, ddeath: ddeath})
	  @person.build_doc({doctype: doctype, docser: docser, docnum: docnum, docdate: docdate, name_vp: name_or, mr: mr})
	  @person.build_addres_g({bomg: bomg, subj: subj[0], indx: indx, okato: okato, npname: npname, ul: ul, dom: dom, korp: korp, kv: kv,dreg: dreg})
	  # @person.build_addres_p()
	  @person.build_op({id: id_fl, tip_op: tip_op, user_id: user_id, date_uvoln: date_uvoln, created_at: dvizit, updated_at: date_modif, active: active})
	  @person.build_vizit({dvizit: dvizit, method: method, petition: petition.to_i, rsmo: rsmo, rpolis: rpolis, fpolis: fpolis})
	  @person.vizit.build_insurance({ter_st: ter_st, ogrnsmo: ogrnsmo, enp: enp, erp: erp})
	  @person.vizit.insurance.build_polis({vpolis: vpolis, spolis: spolis, npolis: npolis, dbeg: dbeg, dend: dend, dstop: dstop, datepolis: date_polis, datepp: datepp})
   
             @person.save



    
	      # statuses << @person.op
      # [przcod,id_fl,tip_op,status,fam,im,ot,w,dr,kod,ss,phone,email,fiopr,parents,contact,ddeath,doctype,docser,docnum,docdate,name_vp,mr,bomg,kod_tf,indx,okato,npname,ul,dom,korp,kv,dreg,dvizit,method,petition,rsmo,rpolis,fpolis,ter_st,ogrnsmo,enp,erp,vpolis,spolis,npolis,dbeg,dend,dstop,date_polis,datepp,date_uvoln,date_modif]
=begin
      [active,przcod,id_fl,tip_op,status,fam,im,ot,w,dr,kod,ss,phone,email,fiopr,parents,contact,ddeath,doctype,docser,docnum,docdate,name_vp,mr,bomg,subj,indx,okato,npname,ul,dom,korp,kv,dreg,dvizit,method,petition,rsmo,rpolis,fpolis,ter_st,ogrnsmo,enp,erp,vpolis,spolis,npolis,dbeg,dend,dstop,date_polis,datepp,date_uvoln,date_modif]
=end

	end
        i = i+1 
      end
    file.close
    render json: status

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
      when  "005"
	res = 2
      when  "006"
	res = 2
      when  "007"
	res = 2
      when  "010"
	res = 2
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
    @vizit = Vizit.new(params[:vizit])
    
    if @vizit.valid?
      if @vizit.petition == "1"
        @vizit.method = "2"
        @vizit.rsmo = nil
      end
      tip_op = ""
      case (@vizit.rsmo.to_s + @vizit.rpolis.to_s)
        when "0"
          tip_op = "П010"
        when "10"
          tip_op = "П010"
        when "20"
          tip_op = "П031"
        when "30"
          tip_op = "П032"
        when "40"
          tip_op = "П033"
        when "21"
          tip_op = "П034"
        when "31"
          tip_op = "П035"
        when "41"
          tip_op = "П036"
        else
          tip_op = nil
      end
      op = Op.find_by_person_id(@vizit.person_id)
      id_for_op = @vizit.person_id
      if @vizit.save! and op.update_attributes({tip_op: tip_op, active: 1, id: id_for_op})
        redirect_to @vizit, notice: 'Визит успешно сохранен.'
      else
        flash[:error] = "В программе произошла серьезная ошибка. Обратитесь к администратору."
        render :new
      end
        # render json: @vizit
    else
      flash[:error] = "Сохранить не получилось, проверьте ошибки в параметрах."
      render :new
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
  def print_doublecat
    @person = Person.find_by_id(params[:id])
    render :partial => "print_doublecat", :layout => false
  end
end
