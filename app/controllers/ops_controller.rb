# encoding: utf-8
class OpsController < ApplicationController
   require 'builder'
   
   
   def upload
     @a=[]
     ops = Op.select("DISTINCT user_id").all
     fil = Filial.select("DISTINCT filials.id").joins(:users).where(:users => {:id => ops.map(&:user_id)}) 
     
     fil.each do |f|
       @a << { name:"i42007_#{f[:id]}_" + day_to_str(Time.now.day.to_s) + Time.now.month.to_s + Time.now.year.to_s + "1.xml", id: f[:id]}
     end

    respond_to do |format|
      format.html # upload.html.erb
      format.json { render json: @a }
    end
   end
   
  
 
  def files
    hijack_response(generate_builder(params), params[:name])
  end
  
  private
  def hijack_response( out_data, file_name )

    win1251 = out_data#.encode('Windows-1251', 'UTF-8', :xml => :text)
    send_data( win1251, :type => "text/xml", :filename => file_name )
  end 
  def generate_builder(par)
    
  
    _users = User.select("users.id").joins(:filials).where(:filials => { id: par[:id] })
    
    
    ops = []
    _ops = Op.select("n_rec,id,tip_op,person_id").where(:user_id => _users.map(&:id))                   #updated_at: (Time.now.midnight - 4.day)..Time.now.midnight)
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
      doc.oplist(xmlns: "www.kemoms.ru/xsd/zstr") {
	doc.filename(oplist[:filename])
	doc.smocod(oplist[:smocod])
	doc.przcod(oplist[:przcod])
	doc.nrecords(oplist[:nrecords])
	doc.op {
               ops.each { |op|
		  doc.n_rec( op["n_rec"] )
		  doc.id( op["id"] )
		  doc.tip_op( op["tip_op"] )
                  doc.person {
                             doc.fam( op[:person]["fam"] )
                             doc.im( op[:person]["im"] )
                             doc.ot( op[:person]["ot"] )
                             doc.w( op[:person]["w"] )
                             doc.dr( op[:person]["dr"] )
                             doc.true_dr( op[:person]["true_dr"] )
                             doc.c_oksm( op[:person]["c_oksm"] )
                             doc.ss( op[:person]["ss"] )
                             doc.phone( op[:person]["phone"] )
                             doc.email( op[:person]["email"] )
                             doc.fiopr( op[:person]["fiopr"] )
                             doc.contact( op[:person]["contact"] )
                             doc.ddeath( op[:person]["ddeath"] )
                              }
                  doc.doc{
                         doc.doctype( op[:doc]["doctype"] )
                         doc.docser( op[:doc]["docser"] )
                         doc.docnum( op[:doc]["docnum"] )
                         doc.docdate( op[:doc]["docdate"] )
                         doc.name_vp( op[:doc]["name_vp"] )
                         doc.mr( op[:doc]["mr"] )
                          }
                  doc.old_person{
                                if op[:old_person]
				    doc.fam( op[:old_person]["fam"] )
				    doc.im( op[:old_person]["im"] )
				    doc.ot( op[:old_person]["ot"] )
				    doc.w( op[:old_person]["w"] )
				    doc.dr( op[:old_person]["dr"] )
				    doc.old_enp( op[:old_person]["old_enp"] )
                                end
                                }
                  doc.old_doc{
                             if op[:old_doc]
				doc.doctype( op[:old_doc]["doctype"] )
				doc.docser( op[:old_doc]["docser"] )
				doc.docnum( op[:old_doc]["docnum"] )
				doc.docdate( op[:old_doc]["docdate"] )
				doc.name_vp( op[:old_doc]["name_vp"] )
				doc.mr( op[:old_doc]["mr"] )
                             end
                             }
                  doc.addres_g{
                              doc.bomg( op[:addres_g]["bomg"] )
                              doc.subj( op[:addres_g]["subj"] )
                              doc.indx( op[:addres_g]["indx"] )
                              doc.okato( op[:addres_g]["okato"] )
                              doc.rnname( op[:addres_g]["rnname"] )
                              doc.npname( op[:addres_g]["npname"] )
                              doc.ul( op[:addres_g]["ul"] )
                              doc.dom( op[:addres_g]["dom"] )
                              doc.korp( op[:addres_g]["korp"] )
                              doc.kv( op[:addres_g]["kv"] )
                              doc.dreg( op[:addres_g]["dreg"] )
                               }
                  doc.addres_p{
                               if op[:addres_p]
				  doc.subj( op[:addres_p]["subj"] )
				  doc.indx( op[:addres_p]["indx"] )
				  doc.okato( op[:addres_p]["okato"] )
				  doc.rnname( op[:addres_p]["rnname"] )
				  doc.npname( op[:addres_p]["npname"] )
				  doc.ul( op[:addres_p]["ul"] )
				  doc.dom( op[:addres_p]["dom"] )
				  doc.korp( op[:addres_p]["korp"] )
				  doc.kv( op[:addres_p]["kv"] )
                              end
                              }
                  doc.vizit{
                            doc.dvizit( op[:vizit]["dvizit"] )
                           doc.method( op[:vizit]["method"] )
                           doc.petition( op[:vizit]["petition"] )
                           doc.rsmo( op[:vizit]["rsmo"] )
                           doc.rpolis( op[:vizit]["rpolis"] )
                           doc.fpolis( op[:vizit]["fpolis"] )
                           }
                  doc.insurance{
                                doc.ter_st( op[:insurance]["ter_st"] )
                               doc.enp( op[:insurance]["enp"] )
                               doc.ogrnsmo( op[:insurance]["ogrnsmo"] )
                               doc.polis{
                                         doc.vpolis( op[:polis]["vpolis"] )
                                        doc.npolis( op[:polis]["npolis"] )
                                        doc.spolis( op[:polis]["spolis"] )
                                        doc.dbeg( op[:polis]["dbeg"] )
                                        doc.dend( op[:polis]["dend"] )
                                        doc.dstop( op[:polis]["dstop"] )
                                        }
                               doc.erp( op[:insurance]["erp"] )
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
    return day_str = "0" + str if str.size == 1
  end
end
#     fl_name = "i42007_0_" + Time.now.day.to_s + Time.now.month.to_s + Time.now.year.to_s + "1"
#     


# op = Op.select("n_rec,fam,docnum,bomg")
#       .where(updated_at: (Time.now.midnight - 1.day)..Time.now.midnight)
#       .joins(:person => [:doc,:addres_g])