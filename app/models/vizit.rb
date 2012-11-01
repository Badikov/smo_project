class Vizit < ActiveRecord::Base
  belongs_to :person
  has_one :insurance, :dependent => :destroy
  
  attr_accessible :dvizit, :fpolis, :method, :petition, :rpolis, :rsmo, :person_id, :insurance_attributes
  
  accepts_nested_attributes_for :insurance
end
