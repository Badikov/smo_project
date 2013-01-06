# encoding: utf-8
class CustomersController < ApplicationController
  
  
  def index
    @respon = []
    fio_array = params[:term].split(" ")
    case fio_array.size
    when 1
      @customer = Person.order(:fam, :im).where("fam like ?", "#{fio_array[0]}%")
    when 2
      @customer = Person.order(:fam, :im)
      .where("fam = \"#{fio_array[0]}\" and im like ?", "#{fio_array[1]}%")
    when 3
      @customer = Person.order(:fam, :im)
      .where("fam = \"#{fio_array[0]}\" and im = \"#{fio_array[1]}\" and ot like ?", "#{fio_array[2]}%")
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
    @person = Person.find_by_id(params[:id])

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
    @op = @person.op
    
    @person.update_attributes({ ddeath: d})
    
    @op.update_attributes({ active: 0, tip_op: "П022", date_uvoln: DateTime.now })
    
    render json: status, :nothing => true
  end
  
  def edit_ops_as_doublicat
    # 023 - 
  end
  
  def edit_polis
    # 060
    @op = Op.find_by_person_id(params[:id])
    @vizit = Vizit.find_by_person_id(params[:id])
    @polis = @vizit.insurance.polis
    
    @polis.update_attributes({dbeg: DateTime.now, dend: nil, spolis: nil, vpolis: 3})
    @op.update_attributes({tip_op: "П060"})
    render json: status, :nothing => true
  end
  
  
  def edit
    @person = Person.find_by_id(params[:id])
    
    respond_to do |format|
       format.html # edit.html.erb
       
     end
  end
end
