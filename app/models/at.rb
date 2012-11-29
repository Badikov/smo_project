class At < ActiveRecord::Base
  belongs_to :person
  
  attr_accessible :date_b, :date_e, :date_z, :kdatemu, :kdmu, :type_at, :created_at, :id, :person_id, :updated_at
end
