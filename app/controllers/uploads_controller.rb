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
    
     # render json: @ini_file
  end
  def save_numbers
    directory = "public/numbers"
    name = "numbers.ini"
    path = File.join(directory, name)
    ini_file = IniFile.load(path)
    
    ini_file["series"] = {:start => params["start_series"],:end => params["end_series"]}
    ini_file["numbers"] = {:start => params["start_numbers"],:end => params["end_numbers"]}
    
    if ini_file.write
      redirect_to home_path, notice: 'Изменения внесены успешно.'
    else
      render :numbers, alert: 'Не удалось сохранить изменения.'
    end
  end
end
