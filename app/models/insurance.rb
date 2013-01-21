# encoding: utf-8
class Insurance < ActiveRecord::Base
  belongs_to :vizit
  has_one :polis, :dependent => :destroy#, :validate => false
  
  attr_accessible :id, :enp, :erp, :ogrnsmo, :ter_st, :polis, :vizit_id, :created_at, #<<== creat - временно для переноса данных
  :polis_attributes
  
  accepts_nested_attributes_for :polis
  
  alias_method :polis=, :polis_attributes=
  
    
  validates_associated :polis
  
  validates :enp, :length => { :is => 16, :message => "должен быть 16 цифр" }, :allow_blank => true
  
  before_create :app_logic
  
  protected
  
  def app_logic
    logger.debug { "привет из страхования"  }
    self.ter_st = "32000"
    self.ogrnsmo = "1042201923720"
  end
end
