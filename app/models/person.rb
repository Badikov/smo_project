# encoding: utf-8
class Person < ActiveRecord::Base
  
  has_one :doc, :dependent => :destroy
  has_one :old_person, :dependent => :destroy
  has_one :old_doc, :dependent => :destroy
  has_one :addres_g, :dependent => :destroy
  has_one :addres_p, :dependent => :destroy
  has_one :op, :dependent => :destroy
  has_one :vizit, :dependent => :destroy
  has_one :personb, :dependent => :destroy
  has_many :ats
  has_one :representative, :dependent => :destroy
    
  attr_accessible :c_oksm, :contact, :ddeath, :dr, 
  :email, :fam, :fiopr, :im, :ot, :phone, :ss, :true_dr, :w,:status, 
	:representative, :doc, :addres_g, :addres_p,
  :doc_attributes, :addres_g_attributes, :addres_p_attributes, :representative_attributes,
  :op_attributes, :vizit_attributes, :personb_attributes, :ats_attributes
  
  accepts_nested_attributes_for :doc, :old_person, :old_doc, :addres_g, :addres_p, :op, :vizit, :representative
  
  alias_method :doc=, :doc_attributes=
  alias_method :addres_g=, :addres_g_attributes=
  alias_method :addres_p=, :addres_p_attributes=
  alias_method :representative=, :representative_attributes=
  
  
  # validates :fam, :im, :ot, :w, :c_oksm, :status, :dr, :presence => true, :if => :can_validate?
  # validates :fam, :im, :ot, :w, :c_oksm, :status, :dr, :presence => {:message => "Не должно быть пустым."}
  # validates :fam, :im, :ot, :phone, :length => { :maximum => 40, :too_long => "%{count} символов это максимум возможного." }
  # validates :c_oksm, :length => { :is => 3 }
  # validates :ss, :length => { :is => 14 }, :allow_blank => true
  # validates :email, :length => { :maximum => 50, :too_long => "%{count} символов это максимум возможного." }
  # validates :ss, :format => { :with => /^\d{3}-\d{3}-\d{3}(-|\s)\d{2}$/ , :message => "не соответствует шаблону"}, :allow_blank => true
  
  # validates_associated :doc, :addres_g, :addres_p, :representative
  
  def can_validate?
    true
  end
end
