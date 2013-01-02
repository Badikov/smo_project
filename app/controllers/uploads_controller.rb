# encoding: utf-8
class UploadsController < ApplicationController
  def upload_xml
  end
  def update
  end
  def create
    items = []
    tm =[]
    upload = params[:xml_file]
    save_file = XmlFile.save(upload)
    
    @xml_fl = Hash.from_xml(upload['datafile'].read).to_hash
    items = @xml_fl["DATAPACKET"]["ROWDATA"]["ROW"]
    items.each do |item|
      tm = item
    end
     # logger.debug @xml_file
    render json: tm #:text => "File has been uploaded successfully"
  end
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
end
