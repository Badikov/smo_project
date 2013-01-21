class At < ActiveRecord::Base
  belongs_to :person
  belongs_to :nsilpu, :foreign_key => 'kdmu',:readonly => true
  belongs_to :ate, :foreign_key => 'kdatemu',:readonly => true
  
  attr_accessible :date_b, :date_e, :date_z, :kdatemu, :kdmu, :type_at, :created_at, :id, :person_id, :updated_at
  
  # alias_method :kdatemu=, :kdate=
  
  before_save :insert_dates
  
  def insert_dates
    self.type_at = "T" if self.type_at.nil?
    self.date_z = DateTime.now if self.date_z.nil?
    self.date_b = DateTime.now if self.date_b.nil?
  end
end
