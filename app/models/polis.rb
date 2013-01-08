# encoding: utf-8
class Polis < ActiveRecord::Base
  belongs_to :insurance
  
  attr_accessible :dbeg, :dend, :dstop, :npolis, :spolis, :vpolis, :datepolis, :datepp
    
  validates :npolis, :format => { :with => /^\d{6,}$/ , :message => "должны быть только цифры"}, :allow_blank => false
  validates :spolis, :length => { :is => 3 }, :allow_blank => true, :format => { :with => /^\d{3}$/ , :message => "должны быть только 3 цифры"}
  
  validates_each :npolis do |record, attr, value|
    if record.spolis.blank?
      record.errors.add(attr, 'длинна номера бланка полиса 11 цифр') if value.size != 11
    else
      
      record.errors.add(attr, 'длинна номера временного свидетельства 6 цифр') if value.size != 6
    end
  end
  
  before_validation :check_numbers, :if => :before_check_numbers?
  before_save :spolis_nil
  
  private
  def before_check_numbers?
    if self.new_record? and !self.spolis.blank?
      true
    end
  end
  def check_numbers
      directory = "public/numbers"
      name = "numbers.ini"
      path = File.join(directory, name)
      ini_file = IniFile.load(path).to_h
      
      flag = false
      ini_file.values.each do |line|
        if line["start"].upto(line["end"]).to_a.include?(self.npolis) and line["series"] == self.spolis
          flag = true
        end
      end
      
      if flag
        logger.debug { "серия - номер: true"  }
        true
      else
        logger.debug { "серия - номер: false"  }
        self.errors.add(:npolis, 'номер временного свидетельства введен не правильно.')
        false
      end
  end
  
  def spolis_nil
    self.spolis = nil if self.spolis.blank?
  end
end
