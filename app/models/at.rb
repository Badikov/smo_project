class At < ActiveRecord::Base
  belongs_to :person
  # belongs_to :nsilpu, :foreign_key => 'kdmu',:readonly => true
  # belongs_to :ate, :foreign_key => 'kdatemu',:readonly => true
  acts_as_xlsx :columns => [:kdatemu, :kdmu, :type_at]
  
  attr_accessible :date_b, :date_e, :date_z, :kdatemu, :kdmu, :type_at, :created_at, :id, :person_id, :updated_at
  
  scope :territor, -> { where("type_at= ?", "T") }
  scope :facktice, -> { where("type_at= ?", "F") }
  
  def self.count_people_in_ate
    includes(:person => :op).where(["ops.active= ?", true]).count(:person_id, :group => 'kdatemu')
  end
  # scope :people_in_lpu, ->(kdatemu, kdmu) { where(["kdatemu= ? and kdmu= ?", kdatemu, kdmu]).uniq.pluck(:person_id) }
  def self.count_people_in_lpu(kdatemu, kdmu)
    includes(:person => :op).where(["ops.active= ? and kdatemu= ? and kdmu= ?", true, kdatemu, kdmu]).count(:person_id)
  end
  # id территорий, где есть активные застрахованные
  def self.to_ates
    # includes(:person => [:op]).where(["ops.active= ?", true]).uniq.pluck(:kdatemu)
    joins(:person => :op).where(["ops.active= ?", true]).uniq.pluck(:kdatemu)
  end
  # коды поликлиник на конкретной террирории
  def self.to_kdmus(kdatemu)
    where("kdatemu= ?", kdatemu).uniq.pluck(:kdmu)
  end
   
  before_save :insert_dates
  
  def insert_dates
    self.type_at = "T" if self.type_at.nil?
    self.date_z = DateTime.now if self.date_z.nil?
    self.date_b = DateTime.now if self.date_b.nil?
  end
end
