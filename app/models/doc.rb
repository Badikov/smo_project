class Doc < ActiveRecord::Base
  belongs_to :person
#   belongs_to :tipdoc#, :foreign_key => "doctype"
  
  attr_accessible :docdate, :docnum, :docser, :doctype, :mr, :name_vp, :ig_doctype, :ig_docser, :ig_docnum,
		  :ig_docdate, :ig_name_vp, :ig_startdate, :ig_enddate, :docname
   
end
