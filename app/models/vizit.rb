# encoding: utf-8
class Vizit < ActiveRecord::Base
  belongs_to :person
  has_one :insurance, :dependent => :destroy
  
  attr_accessible :dvizit, :fpolis, :method, :petition, :rpolis, :rsmo, :person_id, :insurance,
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
  
  after_validation :dates_logic
  before_save :rpolis_nil #TODO -- только для новых застрахованных... отключить для клиентов
  
  def dates_logic
    self.method = "2" if self.method.nil? #nil если был представитель, на форме method disabled
    self.dvizit = DateTime.now if self.dvizit.nil? #дата визита - сейчас для всех кроме по ходатайству
    self.insurance.polis.dbeg = self.dvizit #дата начала действия документа страхования
    if self.insurance.erp == 0 || (self.insurance.erp? and self.rpolis?)
      self.insurance.polis.dend = self.insurance.polis.dbeg + 42.day
      self.insurance.polis.vpolis = 2
    else
      self.insurance.polis.vpolis = 3
    end
  end
  def rpolis_nil
    self.rpolis = nil
  end
end
