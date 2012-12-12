class Representative < ActiveRecord::Base
  belongs_to :person
  
  attr_accessible :fam, :im, :ot, :parent, :doctype, :docser, :docnum, :docdate, :phone
    
end
