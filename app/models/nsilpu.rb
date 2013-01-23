class Nsilpu < ActiveRecord::Base
  belongs_to :ate, :foreign_key => 'kdate',:readonly => true
  
    
  attr_accessible :kdate, :kdate_ur, :kdlpu, :kdlpu_ur, :kdtype, :namelpu, :status
  
  scope :lpus_of_ate, ->(kdate) { where("kdate = ?", kdate).order(:namelpu) }
end
