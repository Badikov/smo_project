class Op < ActiveRecord::Base
  belongs_to :user
  belongs_to :person
  
  
  attr_accessible :id, :active, :tip_op, :updated_at, :user_id, :date_uvoln, :created_at
 
  
  self.primary_key = "id"
end
