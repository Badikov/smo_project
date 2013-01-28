class At < ActiveRecord::Base
  belongs_to :person
  # belongs_to :nsilpu, :foreign_key => 'kdmu',:readonly => true
  # belongs_to :ate, :foreign_key => 'kdatemu',:readonly => true
  
  attr_accessible :date_b, :date_e, :date_z, :kdatemu, :kdmu, :type_at, :created_at, :id, :person_id, :updated_at
  
  scope :territor, -> { where("type_at= ?", "T") }
  scope :facktice, -> { where("type_at= ?", "F") }
  
   
  before_save :insert_dates
  
  def insert_dates
    self.type_at = "T" if self.type_at.nil?
    self.date_z = DateTime.now if self.date_z.nil?
    self.date_b = DateTime.now if self.date_b.nil?
  end
end
