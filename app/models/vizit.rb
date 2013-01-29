# encoding: utf-8
class Vizit < ActiveRecord::Base
  belongs_to :person
  has_one :insurance, :dependent => :destroy, :include => :polis#, :validate => false
  
  attr_accessible :id, :dvizit, :fpolis, :method, :petition, :rpolis, :rsmo, :person_id, :insurance, :created_at, #<<== creat - временно для переноса данных
  :insurance_attributes
  
  accepts_nested_attributes_for :insurance
  
  alias_method :insurance=, :insurance_attributes=
  
  validates_associated :insurance
  
  validates_each :dvizit do |record, attr, value|
    logger.debug { value }
    if record.petition == "1"
      record.errors.add(attr, 'введите дату ходатайства') if value.nil?
    end
  end
  
  before_create :dates_logic_create
  # before_save 
  before_update :logic_for_update_from_doublecat
  # around_save :petition_logic
  
  protected

  def dates_logic_create
    logger.debug { "привет из визита create"  }
    self.method = "2" if self.method.nil? #nil если был представитель, на форме method disabled
    self.dvizit = DateTime.now if self.dvizit.nil? #дата визита - сейчас для всех кроме по ходатайству
    self.insurance.polis.foo = self.rpolis
    self.rpolis = nil unless self.rsmo.nil?
    if self.petition == "1"
        self.method = "2"
        self.rsmo = nil
    end
  end
  def logic_for_update_from_doublecat
    logger.debug { "привет из визита2"  }
    # 
    self.dvizit = DateTime.now
    self.insurance.polis.foo = self.rpolis
    # @self.rsmo = nil
  end
end
