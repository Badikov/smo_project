class Vizit < ActiveRecord::Base
  belongs_to :person
  has_one :insurance, :dependent => :destroy
  
  attr_accessible :dvizit, :fpolis, :method, :petition, :rpolis, :rsmo, :person_id, :insurance,
  :insurance_attributes
  
  accepts_nested_attributes_for :insurance
  
  alias_method :insurance=, :insurance_attributes=
  
  # validates_associated :insurance
  
  
end
