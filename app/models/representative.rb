# encoding: utf-8
class Representative < ActiveRecord::Base
  belongs_to :person
  
  attr_accessible :fam, :im, :ot, :parent, :doctype, :docser, :docnum, :docdate, :phone#, :created_at #<<== creat - временно для переноса данных
    
  validates :fam, :im, :ot, :parent, :doctype, :docser, :docnum, :docdate,:presence => true, :if => :is_more_younger_than_18?
  validates :fam, :im, :ot, :parent, :doctype, :docser, :docnum, :docdate,:presence => {:message => "Не должно быть пустым."}
  
  def person_age_18
      return @person_age_18
  end
  def person_age_18=(value)
      @person_age_18 = value
  end
  
  protected
  def is_more_younger_than_18?
    if Date.current < self.person_age_18
      true
    else
      false
    end
  end
end
