# encoding: utf-8
class AtsController < ApplicationController
  require 'builder'
  
  def create_links
    d = params[:date]
#    d =  'Thu Nov 12 2012 00:00:00 GMT+0700 (NOVT) '
    d = DateTime.strptime(d, "%a %b %d %Y %H:%M:%S GMT%z") #if d.empty?
    @a=[]
    
    ats = At.where(updated_at: (d.beginning_of_day)..(d.end_of_day))
    
    render json: @a.size == 0 ? 201 : @a, :nothing => true
  end

  def files
  end
end
