# encoding: utf-8
class VizitsController < ApplicationController
  before_filter :require_user
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
    vizit = Vizit.find_by_id(params[:id])
     @person = vizit.person

     # (1..1510).each do |n| 
     #  @person = Person.find_by_id(n)
     #  @person.destroy
     #   
     # end
     # render json: status
     respond_to do |format|
       format.html # show.html.erb
       format.json { render json: @person }
     end
  end
  # DELETE /vizits/1
  # DELETE /people/1.json 566
  def destroy
    
  end
  def index
    statuses =[]
    s_oksm = ""
    file = File.open("p_24.txt")
    i = 0
      file.each do |line|
	
	if  i > 0
	  # str = line#.delete("null")
    przcod, id_fl, tip_op, status, fam, im, ot, w, dr, kod, ss, phone, email, fam_pr, im_pr, ot_pr, parents, ser_pr, nom_pr, dat_pr, typ_pr, tel_pr, ddeath, doctype, docser, docnum, docdate, name_vp, mr, bomg, kod_tf, indx, okato, npname, ul, dom, korp, kv, dreg, dvizit, method, petition, rsmo, rpolis, fpolis, ter_st, ogrnsmo, enp, erp, vpolis, spolis, npolis, dbeg, dend, dstop, date_polis, datepp, date_uvoln, date_modif = line.chomp("\n").split("\t")

	  # przcod,id_fl,tip_op,status,fam,im,ot,w,dr,kod,ss,phone,email,fiopr,parents,contact,ddeath,doctype,docser,docnum,docdate,name_vp,mr,bomg,kod_tf,indx,okato,npname,ul,dom,korp,kv,dreg,dvizit,method,petition,rsmo,rpolis,fpolis,ter_st,ogrnsmo,enp,erp,vpolis,spolis,npolis,dbeg,dend,dstop,date_polis,datepp,date_uvoln,date_modif = str.chomp("\n").split("\t")
	  s_oksm= Oksm.find_by_kod(kod).alfa3 unless kod.blank?
	  user_id = cod_podrazdeleniy(przcod)
	  ss = ss.blank? ? nil : ss
    dat_pr = dat_pr.blank? ? nil : dat_pr.to_date
    tel_pr = tel_pr.blank? ? nil : tel_pr
	  dr = dr.blank? ? nil : dr.to_date
	  ddeath = ddeath.blank? ? nil : ddeath.to_date
	  docdate =docdate.blank? ? nil : docdate.to_date
	  dreg = dreg.blank? ? nil : dreg.to_date
	  dvizit = dvizit.blank? ? '01.01.1901'.to_date : dvizit.to_date
	  dbeg = dbeg.blank? ? nil : dbeg.to_date
	  dend = dend.blank? ? nil : dend.to_date
	  dstop = dstop.blank? ? nil : dstop.to_date
	  date_modif = date_modif.blank? ? nil : date_modif.to_date
	  date_polis = date_polis.blank? ? nil : date_polis.to_date
	  datepp = datepp.blank? ? nil : datepp.to_date
	  date_uvoln = date_uvoln.blank? ? nil : date_uvoln.to_date
	  name_or = name_vp.upcase
	  subj = Subekti.find_by_kod_tf(kod_tf).kod_okato     #.select("distinct kod_okato").where(:kod_tf => kod_tf).map(&:kod_okato)
	  korp = korp.blank? ? nil : korp
	  kv = kv.blank? ? nil : kv
	  enp = enp.blank? ? nil : enp
	  spolis = spolis.blank? ? nil : spolis
	  npolis = npolis.blank? ? nil : npolis
	  vpolis = vpolis.blank? ? 1 : vpolis
	  method = method.blank? ? 1 : method
	  petition = petition.blank? ? 0 : petition
    active = date_uvoln.nil? ? 1 : 0
	  @person = Person.new({status: status,fam: fam, im: im, ot: ot, w: w, dr: dr, true_dr: 1, c_oksm: s_oksm, ss: ss,phone: phone,
	                        email: email, ddeath: ddeath, created_at: dvizit})
	  @person.build_doc({doctype: doctype, docser: docser, docnum: docnum, docdate: docdate, name_vp: name_or, mr: mr, created_at: dvizit})
	  @person.build_addres_g({bomg: bomg, subj: subj, indx: indx, okato: okato, npname: npname, ul: ul, dom: dom, korp: korp, kv: kv,dreg: dreg, created_at: dvizit})
	  # # @person.build_addres_p()
    unless fam_pr.blank? and im_pr.blank? and ot_pr.blank?
          @person.build_representative({fam: fam_pr, im: im_pr, ot: ot_pr, parent: parents, doctype: typ_pr, docser: ser_pr, docnum: nom_pr, docdate: dat_pr, phone: tel_pr, created_at: dvizit})
    end

	  @person.build_vizit({dvizit: dvizit, method: method, petition: petition, rsmo: rsmo, rpolis: rpolis, fpolis: fpolis, created_at: dvizit})
	  @person.vizit.build_insurance({ter_st: ter_st, ogrnsmo: ogrnsmo, enp: enp, erp: erp, created_at: dvizit})
	  @person.vizit.insurance.build_polis({vpolis: vpolis, spolis: spolis, npolis: npolis, dbeg: dbeg, dend: dend, dstop: dstop, datepolis: date_polis, datepp: datepp, created_at: dvizit})
    
    @person.build_op({id: id_fl, tip_op: tip_op, user_id: user_id, date_uvoln: date_uvoln, created_at: dvizit, updated_at: date_modif, active: active})

              # @person.save



    
	      # statuses <<  @person.doc.as_json
        # s_oksm << user_id << ss << dr << ddeath << subj << petition << method << date_polis << dvizit
        # [przcod, id_fl, tip_op, status, fam, im, ot, w, dr, kod, ss, phone, email, fam_pr, im_pr, ot_pr, parents, ser_pr, nom_pr, dat_pr, typ_pr, tel_pr, ddeath, doctype, docser, docnum, docdate, name_vp, mr, bomg, kod_tf, indx, okato, npname, ul, dom, korp, kv, dreg, dvizit, method, petition, rsmo, rpolis, fpolis, ter_st, ogrnsmo, enp, erp, vpolis, spolis, npolis, dbeg, dend, dstop, date_polis, datepp, date_uvoln, date_modif]
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
 
      if @vizit.save 
        op = Op.find_by_person_id(@vizit.person_id)
        op.update_attributes({tip_op: tip_op, active: 1})
        redirect_to @vizit, notice: 'Визит успешно сохранен.'
      else
        flash[:error] = "Сохранить не получилось, проверьте ошибки в параметрах. Проверьте!!! Правильно ли стоят флажки!!!"
        render :new
      end
  end
  
  
  
  
  def print_polis
    
    @person = Person.find_by_id(params[:id])
    
    render :partial => "print_polis", :layout => false
  end
  def print_petition
    # require 'smo.rb'
    @person = Person.find_by_id(params[:id])
    unless @person.representative
      # @fio = Smo.padeg @person.fam, @person.im, @person.ot, @person.w
      @fio = @person.fam + ' ' + @person.im + ' ' + @person.ot
    else
      # @fio = Smo.padeg @person.representative.fam, @person.representative.im, @person.representative.ot, @person.representative.parent == 'ОТЕЦ' ? 1 : 2
      @fio = @person.representative.fam + ' ' + @person.representative.im + ' ' + @person.representative.ot
    end
    # if @fio.nil?
    #   @fio = @person.fam + ' ' + @person.im + ' ' + @person.ot
    # end
    logger.debug {'ФИО - ' + @fio }
    render :partial => "print_petition", :layout => false
  end
  def print_doublecat
    @person = Person.find_by_id(params[:id])
    render :partial => "print_doublecat", :layout => false
  end
end
