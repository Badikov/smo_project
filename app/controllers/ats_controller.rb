# encoding: utf-8
class AtsController < ApplicationController
  require 'builder'
  
  def create_links
    d = params[:date]
    
    # d =  'Thu Nov 12 2012 00:00:00 GMT+0700 (NOVT) '
    d = DateTime.strptime(d, "%a %b %d %Y %H:%M:%S GMT%z") #if d.empty?
    
    people = Person.joins(:ats).where(:ats => {updated_at: (d.beginning_of_day)..(d.end_of_day)}).group(:person_id)
    
    if people.size != 0
      # имя файла из заявленной даты
      file_name = "AT_S_180_" + d.year.to_s + day_to_str(d.month.to_s) + day_to_str(d.day.to_s) + "_1.xml"
      hijack_response(generate_builder(people, file_name), file_name)
    else
      render json: people.size == 0 ? 201 : 200, :nothing => true
    end
  end

  def files
  end
  
  private
  def hijack_response( out_data, file_name )

    win1251 = out_data#.encode('Windows-1251', 'UTF-8', :xml => :text)
    send_data( win1251, :type => "text/xml", :filename => file_name )
  end
  def generate_builder(people, file_name)
    $KCODE = 'Windows-1251'
    doc = Builder::XmlMarkup.new( :target => out_string = "")
    doc.instruct! :xml, :version => "1.0", :encoding =>"windows-1251"
    doc.ATLIST(xmlns: "www.kemoms.ru/xsd/zstr") {
      doc.FILENAME(minus_5(file_name))
      doc.NRECORDS(people.count.size)
      doc.TYPE("S")
      _i = 1
      people.each do |person|
        doc.PERS {
          doc.ID(person.op.id)
          doc.FAM(person.fam)
          doc.IM(person.im)
          doc.OT(person.ot)
          doc.DR(person.dr)
          doc.NPOLIS(person.vizit.insurance.enp.nil? ? person.vizit.insurance.polis.npolis : person.vizit.insurance.enp)
          doc.SPOLIS(person.vizit.insurance.polis.spolis)
          person.ats.each do |at|
            doc.AT {
              doc.TYPE(at.type_at)
              doc.KDATEMU(at.kdatemu)
              doc.KDMU(at.kdmu)
              doc.DATE_Z(at.date_z.nil? ? nil : at.date_z.to_date)
              doc.DATE_B(at.date_b.nil? ? nil : at.date_b.to_date)
              doc.DATE_E(at.date_e.nil? ? nil : at.date_e.to_date)
            }
          end
        }
      end
    }  
   return out_string 
  end
end
