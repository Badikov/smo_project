class TipdocsController < ApplicationController
  def index
    require "net/http"
    str_guid = Net::HTTP.get(URI.parse(URI.encode("http://mozilla.pettay.fi/cgi-bin/mozuuid.pl")))
                                       
    
    @tipdoc  = str_guid[0,36]
#     @tipdoc = Tipdoc.order(:docname).where("docname like ?", "%#{params[:term]}%")
#     
    render json: @tipdoc
  end
end
