# encoding: utf-8
class OpsController < ApplicationController
  require 'builder'
  
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
       @a << { name:"i42007_#{f[:id]}_" + day_to_str(d.day.to_s) + day_to_str(d.month.to_s) + d.year.to_s.slice(2,2) + "1.xml", id: f[:id]}
     end
#     @a << { name:"i42007_1_021120121.xml", id: 1 } << { name:"i42007_2_021120121.xml", id: 2 } << { name:"i42007_3_021120121.xml", id: 3 }
     
     render json: @a
  end
  
 
  def files
    hijack_response(generate_builder(params), params[:name])
  end
  
  private
  def hijack_response( out_data, file_name )

    win1251 = out_data#.encode('Windows-1251', 'UTF-8', :xml => :text)
    send_data( win1251, :type => "text/xml", :filename => file_name )
  end
  #!!!!!!!!!!!!!!!!Запрос данных из базы
  def generate_builder(par)
    _users = User.select("users.id").joins(:filials).where(:filials => { id: par[:id] })
    
    ops = []
    #!!!!!!!!!! отбирает записи по массиву юзеров одного филиала и дате
    _ops = Op.select("n_rec,id,tip_op,person_id").where(:user_id => _users.map(&:id), :updated_at => (@@where_str.beginning_of_day)..(@@where_str.end_of_day))                   #updated_at: (Time.now.midnight - 4.day)..Time.now.midnight)
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
	doc.OP {
               ops.each { |op|
		  doc.N_REC( op["n_rec"] )
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
                             doc.FIOPR( op[:person]["fiopr"] )
                             doc.CONTACT( op[:person]["contact"] )
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
                             else
				doc.DOCTYPE()
				doc.DOCSER()
				doc.DOCNUM()
				doc.DOCDATE()
				doc.NAME_VP()
				doc.MR()
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
                               if op[:addres_p]["okato"] != ""  #!!!!!!!!!!!!всегда не nil , но может иметь пустые значения, это используется
				  doc.SUBJ( op[:addres_p]["subj"] ) #!!!! в insurance _form для определения территории страхования ter_st
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
                            doc.DVIZIT( op[:vizit]["dvizit"] )
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
                                        doc.DBEG( op[:polis]["dbeg"] )
                                        doc.DEND( op[:polis]["dend"] )
                                        doc.DSTOP( op[:polis]["dstop"] )
                                        doc.DATEPOLIS( op[:polis]["datepolis"])
                                      else
                                        doc.VPOLIS()
                                        doc.NPOLIS()
                                        doc.SPOLIS()
                                        doc.DBEG()
                                        doc.DEND()
                                        doc.DSTOP()
                                        doc.DATEPOLIS()
                                      end
                                        }
                               doc.ERP( op[:insurance]["erp"] )
                               }
                        }
         }
	}

#       File.atomic_write(fl_name + ".xml") do |file|
# 	file.write(xml_yes)
     return out_string
  end
  def minus_5(str)
    len = str.size - 5
    resp_str = str.slice(0..len)
    return resp_str
  end
  def day_to_str(str)
    day_str =""
    if str.size == 1
      day_str = "0" + str 
    else
      day_str = str
    end
    return day_str
  end
end
#     fl_name = "i42007_0_" + Time.now.day.to_s + Time.now.month.to_s + Time.now.year.to_s + "1"
#     


# op = Op.select("n_rec,fam,docnum,bomg")
#       .where(updated_at: (Time.now.midnight - 1.day)..Time.now.midnight)
#       .joins(:person => [:doc,:addres_g])