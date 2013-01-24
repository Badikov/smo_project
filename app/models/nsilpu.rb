class Nsilpu < ActiveRecord::Base
  belongs_to :ate, :readonly => true
  # 
  #   
  attr_accessible :ate_id, :kdate_ur, :kdlpu, :kdlpu_ur, :kdtype, :namelpu, :status
  # 
  scope :lpus_of_ate, ->(ate_id) { where("ate_id = ?", ate_id).order(:namelpu) }
end
