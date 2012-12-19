# encoding: utf-8
class OpsController < ApplicationController
  require 'builder'
  require 'zip/zip'
  
  
  #for CanCan
#   load_and_authorize_resource
  
  @@where_str =DateTime 
   
  def upload

    respond_to do |format|
#       flash[:notice] = "Your account has been created."
      format.html # upload.html.erb
#       format.json { render json: @a }
    end
  end
  def create_links
    d = params[:date]
#    d =  'Thu Nov 12 2012 00:00:00 GMT+0700 (NOVT) '
    d = DateTime.strptime(d, "%a %b %d %Y %H:%M:%S GMT%z") #if d.empty?
    @a=[]
    @@where_str = d
     ops = Op.select("DISTINCT user_id").where(updated_at: (d.beginning_of_day)..(d.end_of_day))
     fil = Filial.select("DISTINCT filials.id").joins(:users).where(:users => {:id => ops.map(&:user_id)}) 
     
     fil.each do |f|
       @a << { name:"i42007_#{f[:id]}_" + day_to_str(d.day.to_s) + day_to_str(d.month.to_s) + d.year.to_s.slice(2,2) + "2.xml", id: f[:id]}
     end
    # @a << { name:"i42007_1_2111121.xml", id: 1 } << { name:"i42007_2_0211121.xml", id: 2 } << { name:"i42007_3_0211121.xml", id: 3 }
     
     render json: @a.size == 0 ? 201 : @a
  end
  
 
  def files
    hijack_response(generate_builder(params), params[:name])
  end
  
  private
  def hijack_response( out_data, file_name )
    # zip_file_name = minus_5(file_name) + ".zip"

    win1251 = out_data#.encode('Windows-1251', 'UTF-8', :xml => :text)
    send_data( win1251, :type => "text/xml", :filename => file_name )
    # t = Tempfile.new("my-temp-filename-#{Time.now}")
    # Zip::ZipFile.open(t.path, Zip::ZipFile::CREATE) do |zipfile|
    #   zipfile.get_output_stream(file_name) { |f| f << out_data }
    # end 
    # send_file t.path, :type => 'application/zip', :disposition => 'attachment', :filename => zip_file_name
    # t.close
    
  end
  #!!!!!!!!!!!!!!!!Запрос данных из базы
  def generate_builder(par)
    _users = User.select("users.id").joins(:filials).where(:filials => { id: par[:id] })
    
    ops = []
    #!!!!!!!!!! отбирает записи по массиву юзеров одного филиала и дате 
    _ops = Op.select("id,tip_op,person_id").where(:user_id => _users.map(&:id) , :updated_at => (@@where_str.beginning_of_day)..(@@where_str.end_of_day))
    
    _ops.each do |op_item|
	    tmp = {}
	    op_item.instance_variables.each do |var|
	      tmp[var.to_s] = op_item.instance_variable_get(var)
	    end
    
	    person = Person.find_by_id(op_item.person_id)
      
	    doc = Doc.select("docdate, docnum, docser, doctype, mr, name_vp").find_by_person_id(person.id)
	    #добавить OLD_DOC & OLD_PERSON!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	    old_person = OldPerson.find_by_person_id(person.id)
	    old_doc = OldDoc.find_by_person_id(person.id)
	    addres_g = AddresG.find_by_person_id(person.id)
	    addres_p = AddresP.find_by_person_id(person.id)
	    vizit = Vizit.find_by_person_id(person.id)
	    insurance = Insurance.find_by_vizit_id(vizit.id)
	    polis = Polis.find_by_insurance_id(insurance.id)
  
	    op = Hash.new
	    op = tmp["@attributes"].merge({ person: person, doc: doc, old_person: old_person, old_doc: old_doc, addres_g: addres_g, addres_p: addres_p, vizit: vizit, insurance: insurance, polis: polis })
	    ops << op
    end
#       fl_name = "i42007_0_" + Time.now.day.to_s + Time.now.month.to_s + Time.now.year.to_s + "1"
    oplist = {filename: minus_5(par[:name]), smocod: "42007", przcod: par[:id].to_s, nrecords: ops.size, op: ops }
#       xml_yes = oplist.to_xml(:skip_instruct => false, :skip_types => true, :dasherize => false, :except => [ :id, :person_id, :updated_at, :created_at ])

  $KCODE = 'Windows-1251'
  doc = Builder::XmlMarkup.new( :target => out_string = "")
  doc.instruct! :xml, :version => "1.0", :encoding =>"windows-1251"
  doc.OPLIST(xmlns: "www.kemoms.ru/xsd/zstr") {
	doc.FILENAME(oplist[:filename])
	doc.SMOCOD(oplist[:smocod])
	doc.PRZCOD(oplist[:przcod])
	doc.NRECORDS(oplist[:nrecords])
	
      n_rec = 1
      ops.each do |op|
      doc.OP { 
		    doc.N_REC( n_rec.to_s )
		    doc.ID( op["id"] )
		    doc.TIP_OP( op["tip_op"] )
        doc.PERSON {
           doc.FAM( op[:person]["fam"] )
           doc.IM( op[:person]["im"] )
           doc.OT( op[:person]["ot"] )
           doc.W( op[:person]["w"] )
           doc.DR( op[:person]["dr"] )
           doc.TRUE_DR( op[:person]["true_dr"] )
           doc.C_OKSM( op[:person]["c_oksm"] )
           doc.SS( op[:person]["ss"] )
           doc.PHONE( op[:person]["phone"] )
           doc.EMAIL( op[:person]["email"] )
           if !op[:person]["fiopr"].nil?
				      str_fiopr = op[:person]["fiopr"]
				      str_contact = op[:person]["contact"]
				      str_fiopr.gsub!("^"," ")
				      str_contact.gsub!("^"," ")
				      doc.FIOPR( str_fiopr )
				      doc.CONTACT( str_contact )
           else
				      doc.FIOPR( op[:person]["fiopr"] )
				      doc.CONTACT( op[:person]["contact"] )
           end
           doc.DDEATH( op[:person]["ddeath"] )
           }
        doc.DOC{
           doc.DOCTYPE( op[:doc]["doctype"] )
           doc.DOCSER( op[:doc]["docser"] )
           doc.DOCNUM( op[:doc]["docnum"] )
           doc.DOCDATE( op[:doc]["docdate"] )
           doc.NAME_VP( op[:doc]["name_vp"] )
           doc.MR( op[:doc]["mr"] )
           }
        doc.OLD_PERSON{
        if op[:old_person]
				   doc.FAM( op[:old_person]["fam"] )
				   doc.IM( op[:old_person]["im"] )
				   doc.OT( op[:old_person]["ot"] )
				   doc.W( op[:old_person]["w"] )
				   doc.DR( op[:old_person]["dr"] )
				   doc.OLD_ENP( op[:old_person]["old_enp"] )
        esle
				   doc.FAM()
				   doc.IM()
				   doc.OT()
				   doc.W()
				   doc.DR()
				   doc.OLD_ENP()
        end
           }
        doc.OLD_DOC{
        if op[:old_doc]
				   doc.DOCTYPE( op[:old_doc]["doctype"] )
				   doc.DOCSER( op[:old_doc]["docser"] )
				   doc.DOCNUM( op[:old_doc]["docnum"] )
				   doc.DOCDATE( op[:old_doc]["docdate"] )
				   doc.NAME_VP( op[:old_doc]["name_vp"] )
				   doc.MR( op[:old_doc]["mr"] )
        end
           }
        doc.ADDRES_G{
           doc.BOMG( op[:addres_g]["bomg"] )
           doc.SUBJ( op[:addres_g]["subj"] )
           doc.INDX( op[:addres_g]["indx"] )
           doc.OKATO( op[:addres_g]["okato"] )
           doc.RNNAME( op[:addres_g]["rnname"] )
           doc.NPNAME( op[:addres_g]["npname"] )
           doc.UL( op[:addres_g]["ul"] )
           doc.DOM( op[:addres_g]["dom"] )
           doc.KORP( op[:addres_g]["korp"] )
           doc.KV( op[:addres_g]["kv"] )
           doc.DREG( op[:addres_g]["dreg"] )
           }
         doc.ADDRES_P{
         if op[:addres_p]  
				   doc.SUBJ( op[:addres_p]["subj"] ) 
				   doc.INDX( op[:addres_p]["indx"] )
				   doc.OKATO( op[:addres_p]["okato"] )
				   doc.RNNAME( op[:addres_p]["rnname"] )
				   doc.NPNAME( op[:addres_p]["npname"] )
				   doc.UL( op[:addres_p]["ul"] )
				   doc.DOM( op[:addres_p]["dom"] )
				   doc.KORP( op[:addres_p]["korp"] )
				   doc.KV( op[:addres_p]["kv"] )
         end
           }
         doc.VIZIT{
           doc.DVIZIT( op[:vizit]["dvizit"].to_date )
           doc.METHOD( op[:vizit]["method"] )
           doc.PETITION( op[:vizit]["petition"] )
           doc.RSMO( op[:vizit]["rsmo"] )
           doc.RPOLIS( op[:vizit]["rpolis"] )
           doc.FPOLIS( op[:vizit]["fpolis"] )
           }
         doc.INSURANCE{
           doc.TER_ST( op[:insurance]["ter_st"] )
           doc.ENP( op[:insurance]["enp"] )
           doc.OGRNSMO( op[:insurance]["ogrnsmo"] )
           doc.POLIS{
           if op[:polis]   
              doc.VPOLIS( op[:polis]["vpolis"] )
              doc.NPOLIS( op[:polis]["npolis"] )
              doc.SPOLIS( op[:polis]["spolis"] )
              doc.DBEG( op[:polis]["dbeg"].to_date )
              doc.DEND( op[:polis]["dend"] )
              doc.DSTOP( op[:polis]["dstop"] )
           else
              doc.VPOLIS()
              doc.NPOLIS()
              doc.SPOLIS()
              doc.DBEG()
              doc.DEND()
              doc.DSTOP()
            end
              }
           doc.ERP( op[:insurance]["erp"] )
           }
         doc.PERSONB()         
	      n_rec = n_rec + 1
        }
      end
	}

#       File.atomic_write(fl_name + ".xml") do |file|
# 	file.write(xml_yes)
     return out_string
  end
  
end
#     fl_name = "i42007_0_" + Time.now.day.to_s + Time.now.month.to_s + Time.now.year.to_s + "1"
#     


# op = Op.select("n_rec,fam,docnum,bomg")
#       .where(updated_at: (Time.now.midnight - 1.day)..Time.now.midnight)
#       .joins(:person => [:doc,:addres_g])