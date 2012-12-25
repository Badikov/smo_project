class Nsilpu < ActiveRecord::Base
  attr_accessible :kdate, :kdate_ur, :kdlpu, :kdlpu_ur, :kdtype, :namelpu, :status
  
  scope :find_by_kdate, ->(kdate) { where("kdate = ?", kdate).order(:namelpu) }
end
