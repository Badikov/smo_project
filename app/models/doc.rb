class Doc < ActiveRecord::Base
  belongs_to :person
  
  attr_accessible :docdate, :docnum, :docser, :doctype, :mr, :name_vp, :ig_doctype, :ig_docser, :ig_docnum,
		  :ig_docdate, :ig_name_vp, :ig_startdate, :ig_enddate 
   
end
