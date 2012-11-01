# encoding: utf-8
class DocsController < ApplicationController
  def index
    require "net/http" 
    require 'oj'
    regions = Net::HTTP.get(URI.parse(URI.encode(
      "http://geocode-maps.yandex.ru/1.x/?origin=jsapi2Geocoder&format=json&rspn=0&lang=ru_RU&geocode=#{params[:term]}")))
    h2 = Oj.load(regions) 
	@regions =[]
	
       3.times {
	  h2.each_value do |v|
	      h2 = v
	  end
       }
       i = h2.size
       j = 0
       i.times {
	  res = h2[j].values.first
	  
	  res2 = res.values.first.values.first
	  r = []
	  r = res2["text"]
	  
	  @regions << r
	j += 1
	}
    
    render json: @regions
  end
end
