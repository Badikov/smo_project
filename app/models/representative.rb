# encoding: utf-8
class Representative < ActiveRecord::Base
  # include ActiveModel::Validations
  
  belongs_to :person
  
  attr_accessible :fam, :im, :ot, :parent, :doctype, :docser, :docnum, :docdate, :phone, :person_id#, :created_at #<<== creat - временно для переноса данных
    
  # validates :fam, :im, :ot, :parent, :doctype, :docser, :docnum, :docdate, :allow_blank => true, :unless => :is_more_younger_than_18?
  # validates :fam, :im, :ot, :parent, :doctype, :docser, :docnum, :docdate,:presence => {:message => "Не должно быть пустым."}
  # validates_with MyValidator
  
  
  def person_age_18
      return @person_age_18
  end
  def person_age_18=(value)
      @person_age_18 = value
  end
  
  protected
  # def is_more_younger_than_18?
  #   logger.debug {'представитель ----->' + self.person_age_18.to_s + '----' + Date.current.to_s }
  #   if Date.current < self.person_age_18
  #     true
  #   else
  #     false
  #   end
  # end
end
class MyValidator < ActiveModel::Validator
  def validate(record)
    if record.fam.blank? || record.im.blank? || record.parent.blank?
      if record.person_age_18 > Date.current
        record.errors[:fam] << 'Need a name starting with X please!'
      end
    end
  end
end