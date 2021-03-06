# encoding: utf-8
class AddresG < ActiveRecord::Base
  belongs_to :person
  
  attr_accessible :bomg, :dom, :dreg, :indx, :korp, :kv, :npname, :okato, :rnname, :subj, :ul #, :created_at #<<== creat - временно для переноса данных
  
  
  
  validates :npname, :okato,:presence => true, :if => :can_validate?
  validates :npname, :okato,:presence => {:message => "Не должно быть пустым."}
  validates :okato, :length => { :is => 11 }
  validates :indx, :length => { :is => 6 },:allow_blank => true
  validates :korp, :kv, :length => { :maximum => 6, :too_long => "%{count} символов это максимум возможного." }, :allow_blank => true
  
  before_save :insert_dates
  
  protected
  def can_validate?
    true
  end
  
  def insert_dates
    self.rnname = nil if self.rnname.blank?
    self.indx = nil if self.indx.blank?
    self.korp = nil if self.korp.blank?
    self.ul = nil if self.ul.blank?
    self.kv = nil if self.kv.blank?
  end

end
