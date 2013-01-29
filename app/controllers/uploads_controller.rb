# encoding: utf-8
class UploadsController < ApplicationController
  before_filter :require_user
  # GET /uploads
  # GET /uploads.json
  def index
    @uploads = Upload.order("created_at DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @uploads.map{|upload| upload.to_jq_upload } }
    end
  end
  # GET /uploads/1
  # GET /uploads/1.json
  def show
    @upload = Upload.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @upload }
    end
  end

  # GET /uploads/new
  # GET /uploads/new.json
  def new
    @upload = Upload.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @upload }
    end
  end

  # GET /uploads/1/edit
  def edit
    @upload = Upload.find(params[:id])
  end

  # POST /uploads
  # POST /uploads.json
  def create
    items = []

    @upload = Upload.new(params[:upload])
    xml_fl = Hash.from_xml(params[:upload]["upload"].read).to_hash
    items = xml_fl["DATAPACKET"]["ROWDATA"]["ROW"]

    respond_to do |format|
      if @upload.save
        #определяем тип содержимого файла по названию файла
        # _json = [@upload.to_jq_upload].to_json
        # 

        logger.debug { items }
        unless @upload.upload_file_name.match(/^\d{5}/).nil?
          logger.debug { '----------------> Ok' }
          create_fackt_pricreplenie(items, @upload.upload_file_name)
        else
          if @upload.upload_file_name.start_with?("UPAKOVKA")
            logger.debug {"======> fack "}
            update_numbers_of_polis(items)
          end
        end

        format.html {
          render :json => [@upload.to_jq_upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json { render json: [@upload.to_jq_upload].to_json, status: :created, location: @upload }
      else
        format.html { render action: "new" }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /uploads/1
  # PUT /uploads/1.json
  def update
    @upload = Upload.find(params[:id])

    respond_to do |format|
      if @upload.update_attributes(params[:upload])
        format.html { redirect_to @upload, notice: 'Upload was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.json
  def destroy
    @upload = Upload.find(params[:id])
    @upload.destroy

    respond_to do |format|
      format.html { redirect_to uploads_url }
      format.json { head :no_content }
    end
  end
 
  # def create
  #   items = []
  #   tm =[]
  #   upload = params[:xml_file]
  #   save_file = XmlFile.save(upload)
    
  #   @xml_fl = Hash.from_xml(upload['datafile'].read).to_hash
  #   items = @xml_fl["DATAPACKET"]["ROWDATA"]["ROW"]
  #   # items.each do |item|
      
  #   #   ser = item["POLIS"][0,3]
  #   #   num = item["POLIS"][3,6]
  #   #   date_polis = item["DATEPOLIS"].to_date
  #   #   polis = Polis.find_by_spolis_and_npolis_and_dbeg(ser,num,date_polis)
  #   #   if polis
  #   #     if polis.update_attributes({npolis: item["BLANK"], vpolis: 3,datepp: DateTime.current,dbeg: nil,dend: nil,spolis: nil})
  #   #       polis.insurance.update_attributes({enp: item["ENP"] ,erp: 1})
  #   #       tm << item
  #   #     end
  #   #   end
  #   # end
  #    # logger.debug @xml_file
  #   render json: items #:text => "File has been uploaded successfully"
  # end

  def numbers
    directory = "public/numbers"
    name = "numbers.ini"
    path = File.join(directory, name)
    @ini_file = IniFile.load(path).to_h
    
     # render json: @ini_file.values.collect{|x| x["series"]}
  end
  def save_numbers
    directory = "public/numbers"
    name = "numbers.ini"
    path = File.join(directory, name)
    # ini_file = IniFile.load(path)
    File.delete(path)
    
    records = Hash.new
    params.each_pair do |key,val|
      if key.start_with?("line")
        k_1, k_2 = key.split("_")
        if records[k_1].nil?
          records[k_1] = {k_2.to_sym => val}
        else
          records[k_1] = records[k_1].merge({k_2.to_sym => val})
        end
      end
    end
    n= records.length
    logger.debug n
    ini_file = IniFile.new( :filename => path )
    i=0
    records.each_pair do |key,val|
      if !val.values.include? ""
        ini_file["line" + i.to_s] = val
        i+= 1
      end
    end
    logger.debug i
    # render json: records
    if ini_file.write
      if n == i
        redirect_to home_path, notice: 'Изменения внесены успешно.'
      else
        redirect_to home_path, :flash => { :info => 'Не все записи были сохранены. Вернитесь в операцию и проверьте, что вы сохранили.'}
      end
    else
      render :numbers, alert: 'Не удалось сохранить изменения.'
    end
  end

  def create_fackt_pricreplenie(rows_aray, file_name)
    kdatemu = file_name[0,2]
    kdmu = file_name[2,3]
    rows_aray.each do |item|
      person = Person.find_by_fam_and_im_and_ot_and_dr(item["FAM"], item["IM"], item["OTCH"], item["DR"].to_date)
      if person
        logger.debug { '----------------> Ok' }
        at = person.ats.where(type_at: "F")
        if at.size > 0
          # , :date_e,
          at.last.update_attributes(kdatemu: kdatemu, kdmu: kdmu, date_b: item["DATEPR"].to_date)
        else
          person.ats.create(kdatemu: kdatemu, kdmu: kdmu, type_at: "F", date_b: item["DATEPR"].to_date)
        end
      end
    end
  end

  def update_numbers_of_polis(items)
    items.each do |item|
      
       ser = item["POLIS"][0,3]
       num = item["POLIS"][3,6]
       date_polis = item["DATEPOLIS"].to_date
       polis = Polis.find_by_spolis_and_npolis_and_dbeg(ser,num,date_polis)
       if polis
         if polis.update_attributes({npolis: item["BLANK"], vpolis: 3,datepp: DateTime.current,dbeg: nil,dend: nil,spolis: nil})
           polis.insurance.update_attributes({enp: item["ENP"] ,erp: 1})
           tm << item
         end
       end
    end
  end


end
