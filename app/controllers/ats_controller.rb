# encoding: utf-8
class AtsController < ApplicationController
  before_filter :require_user
  require 'builder'
  require 'zip/zip'
  require 'tempfile'
  
  def export
    @ats = At.includes(:person => [:op,:addres_g,:vizit => {:insurance => :polis}])
             .where(:kdatemu => params[:kdatemu], :kdmu => params[:kdmu], :ops => {:active => 't'} )
    respond_to do |format|
      format.html
      format.json { render :json => @ats }
      # format.csv { render text: }
      format.xls
      format.xlsx {
        xlsx_package = At.includes(:person => [:op,:addres_g,:vizit => {:insurance => :polis}])
             .where(:kdatemu => params[:kdatemu], :kdmu => params[:kdmu], :ops => {:active => 't'} ).to_xlsx
        begin
          temp = Tempfile.new("posts.xlsx")
          xlsx_package.serialize temp.path
          logger.debug {"===================>" + temp.path.to_s }
          send_file temp.path, :filename => "posts.xlsx", :type => "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        ensure
          # temp.close
          # temp.unlink
        end
      }
    end
  end
  
  def to_mu
    mu_ids = At.to_kdmus(params[:kdatemu])
    @mus = Nsilpu.where(:ate_id => params[:kdatemu], :kdlpu => mu_ids).order(:namelpu)
    render :layout => false
  end
  # используемые территории прикрепления
  def to_attach
    ate_ids = At.to_ates
    @ates = Ate.where(:id => ate_ids).order(:nameate)
  end
  #GET /ats
  def index
    
  end
  # DELETE /ats/1
  def destroy
    @at = At.find(params[:id])
    @at.destroy
    render :inline => '<div class="alert alert-success"><button type="button" class="close" data-dismiss="alert">×</button>Прикрепление удалено</div>'
  end
  
  def create
    txt_mess = ""
    if params.include?(:at)
      @at = At.new(params[:at])
      txt_mess = "Успешно создана запись о территориальном прикреплении к ЛПУ." unless params[:at].include?(:type_at)
      txt_mess = "Успешно создана запись о прикреплении к ЛПУ." if params[:at].include?(:type_at)
    else
      # raise "SomeError message ..."
      @at = At.new(:person_id => params[:person_id], :kdatemu => params[:kdatemu], :kdmu => params[:kdmu])
      txt_mess = "Успешно создана запись о территориальном прикреплении к ЛПУ."
    end
    @at.save
    render :inline => "<div class='alert alert-success'><button type='button' class='close' data-dismiss='alert'>×</button>#{txt_mess}</div>"
  end
  
  def create_fakt
    @at = At.new(params[:at])
    @at.save
    render json: status, :nothing => true
  end
  
  def create_links
    d = params[:date]
    
    # d =  'Thu Nov 12 2012 00:00:00 GMT+0700 (NOVT) '
    d = DateTime.strptime(d, "%a %b %d %Y %H:%M:%S GMT%z") #if d.empty?
    
    people = Person.joins(:ats).where(:ats => {updated_at: (d.beginning_of_day)..(d.end_of_day)}).group(:person_id)
    
    if people.size != 0
      if Time.current.hour < 12
        vers = "1"
      else
        vers = "2"
      end
      # имя файла из заявленной даты
      file_name = "AT_S_180_" + d.year.to_s + day_to_str(d.month.to_s) + day_to_str(d.day.to_s) + "_" + vers + ".xml"
      hijack_response(generate_builder(people, file_name), file_name)
    else
      render json: people.size == 0 ? 201 : 200, :nothing => true
    end
  end

  def files
  end
  
  private
  def hijack_response( out_data, file_name )
    zip_file_name = minus_5(file_name) + ".zip"

    tempfile = File.join('tmp',zip_file_name)
    #logger.debug { tempfile.path }
    Zip::ZipFile.open(tempfile, Zip::ZipFile::CREATE) do |zipfile|
      
      zipfile.get_output_stream(file_name) { |f| f.puts out_data }
      zipfile.close()
    end 
    send_file tempfile, :type => 'application/zip', :disposition => 'attachment', :filename => zip_file_name

    # win1251 = out_data#.encode('Windows-1251', 'UTF-8', :xml => :text)
    # send_data( win1251, :type => "text/xml", :filename => file_name )
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
          doc.NPOLIS(person.vizit.insurance.enp.blank? ? person.vizit.insurance.polis.npolis : person.vizit.insurance.enp)
          doc.SPOLIS(person.vizit.insurance.polis.spolis)
          person.ats.each do |at|
            doc.AT {
              doc.TYPE(at.type_at)
              doc.KDATEMU(at.kdatemu)
              doc.KDMU(at.kdmu)
              # doc.DATE_Z(at.date_z.nil? ? nil : at.date_z.to_date)
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
