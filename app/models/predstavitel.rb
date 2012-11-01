class Predstavitel
  
  include ActiveAttr::Model
 
  
  attribute :fam
  attribute :im
  attribute :ot
  attribute :parents
  attribute :doctype
  attribute :docser
  attribute :docnum
  attribute :docdate, type: Date
  attribute :phone
  
  attr_accessible :fam , :im, :ot, :parents, :doctype, :docser, :docnum, :docdate, :phone

  #validates_presence_of :name
  #validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  #validates_length_of :content, :maximum => 500
end

