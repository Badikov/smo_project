class TipdocsController < ApplicationController
  def index
=begin
    require "net/http"
    str_guid = Net::HTTP.get(URI.parse(URI.encode("http://mozilla.pettay.fi/cgi-bin/mozuuid.pl")))
    @tipdoc  = str_guid[0,36]

=end
=begin
     @tipdoc = Tipdoc.order(:docname).where("docname like ?", "%#{params[:term]}%")
=end
    @tipdoc = Tipdoc.find_by_id(params[:id])
    
     
    render text: @tipdoc.map(&:docname)
  end
end
