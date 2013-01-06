class OldDoc < ActiveRecord::Base
  belongs_to :person
  attr_accessible :docdate, :docnum, :docser, :doctype, :mr, :name_vp, :person_id
end
