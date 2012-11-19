class Op < ActiveRecord::Base
  belongs_to :user
  belongs_to :person
  
  
  attr_accessible :id, :n_rec, :tip_op, :updated_at, :user_id
 
  
  self.primary_key = "n_rec"
end
