# encoding: utf-8
class CustomersController < ApplicationController
  before_filter :require_user
  
  def index
    @respon = []
    unless params[:term].match(/^\d{5}/).nil?
      @customer = Person.joins(:op).where(:ops => {:id => params[:term]})
    else
      fio_array = params[:term].split(" ")
      case fio_array.size
      when 1
        @customer = Person.includes([:op,:doc]).order(:fam, :im).where("fam like ?", "#{fio_array[0]}%")
      when 2
        @customer = Person.includes([:op,:doc]).order(:fam, :im)
        .where("fam = \"#{fio_array[0]}\" and im like ?", "#{fio_array[1]}%")
      when 3
        @customer = Person.includes([:op,:doc]).order(:fam, :im)
        .where("fam = \"#{fio_array[0]}\" and im = \"#{fio_array[1]}\" and ot like ?", "#{fio_array[2]}%")
      end
    end
  
      @customer.each do |custoner|
        @respon << { id: custoner.id, fam: custoner.fam, im: custoner.im, 
          ot: custoner.ot, w: custoner.w == 1 ? 'мужской' : 'женский',
          dr: custoner.dr, docser: custoner.doc.docser, docnum: custoner.doc.docnum,
          active: custoner.op.active}
      
      end
      render :partial => "table_rows", :layout => false
  end
  
  
  def search_person
    # @person = Person.find_by_id(params[:id])
    @person = Person.includes([:op,:vizit,:doc,:addres_g,:representative,:old_person,:old_doc]).find_by_id(params[:id])

    render :partial => "customer" 
  end
  
  
  def search
  end
  
  
  def edit_ops
    # 021 - снятие с учета в связи с постановкой на учет в другом СМО
    @op = Op.find_by_person_id(params[:id])
    
    @op.update_attributes({ active: 0, tip_op: "П021", date_uvoln: DateTime.now })
    
    render json: status, :nothing => true
  end
    
  def death_of_customer
    # 022 - снятие с учета в связи со смертью
    d = params[:date]
    
    # d =  'Thu Nov 12 2012 00:00:00 GMT+0700 (NOVT) '
    d = DateTime.strptime(d, "%a %b %d %Y %H:%M:%S GMT%z") #if d.empty?
    @person = Person.find_by_id(params[:id])
    
    @person.update_attributes({ ddeath: d.to_date })
    
    @person.op.update_attributes({ active: 0, tip_op: "П022", date_uvoln: DateTime.now })
    
    render json: status, :nothing => true
  end
  
  def edit_ops_as_doublicat
    # 023 - 
  end
  
  def edit_ops_foreigner
    # 025 - снятие с учета иностранца
    @op = Op.find_by_person_id(params[:id])
    vizit = Vizit.find_by_person_id(params[:id])
    
    @op.update_attributes({ active: 0, tip_op: "П025", date_uvoln: DateTime.now })
    
    render json: status, :nothing => true
  end
  
  def edit_polis
    # 060
    d = params[:date]
    
    # d =  'Thu Nov 12 2012 00:00:00 GMT+0700 (NOVT) '
    d = DateTime.strptime(d, "%a %b %d %Y %H:%M:%S GMT%z") #if d.empty?
    @person = Person.find_by_id(params[:id])
    
    # @op = Op.find_by_person_id(params[:id])
    # @vizit = Vizit.find_by_person_id(params[:id])
    # @person.vizit.insurance.polis.update_attributes({dbeg: DateTime.now, dend: nil, spolis: nil, vpolis: 3})
    @person.vizit.insurance.polis.update_attributes({dbeg: d})
    
    @person.op.update_attributes({tip_op: "П060"})
    render json: status, :nothing => true
  end
  # GET customers/build_doublecat_polis?id=
  def build_doublecat_polis
    @vizit = Vizit.find_by_person_id(params[:id])
  end
  # POST customers/build_doublecat_polis
  def save_doublecat_polis
    @vizit = Vizit.find_by_id(params[:vizit][:id])
      if  @vizit.update_attributes(params[:vizit])
        @vizit.person.op.update_attributes({tip_op: "П062"})
        # render json: @vizit
        redirect_to @vizit.person, notice: 'Новые данные успешно сохранены.'
      else
        flash[:error] = "Сохранить не получилось, проверьте ошибки в параметрах."
        render :build_doublecat_polis
      end
  end
  
  def edit
    @person = Person.find_by_id(params[:id])
    
    respond_to do |format|
       format.html # edit.html.erb
       
     end
  end
end
