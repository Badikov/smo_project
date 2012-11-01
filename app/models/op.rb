class Op < ActiveRecord::Base
  belongs_to :user
  belongs_to :person
  belongs_to :doc
  belongs_to :old_person
  belongs_to :old_doc
  belongs_to :addres_g
  belongs_to :addres_p
  belongs_to :vizit
  belongs_to :insurance
  belongs_to :personb
  
  attr_accessible :id, :n_rec, :tip_op, :updated_at, :user_id
 
  
  self.primary_key = "n_rec"
end
