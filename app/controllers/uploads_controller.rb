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
  
end
