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
  
  attr_accessible :c_oksm, :contact, :ddeath, :dr, 
  :email, :fam, :fiopr, :im, :ot, :phone, :ss, :true_dr, :w,:status, 
	:doc_attributes, :addres_g_attributes, :addres_p_attributes, 
  :op_attributes, :vizit_attributes, :personb_attributes, :ats_attributes
  
  accepts_nested_attributes_for :doc, :old_person, :old_doc, :addres_g, :addres_p, :op, :vizit
  
  validates :fam, :im, :ot, :w, :c_oksm, :status, :dr, :presence => true
  validates :fam, :im, :ot, :w, :c_oksm, :status, :dr, :presence => {:message => "Не должно быть пустым."}
  validates :fam, :im, :ot, :length => { :maximum => 40, :too_long => "%{count} символов это максимум возможного" }
  validates :c_oksm, :length => { :is => 3 }
  # validates :ss, :format => { :with => /\d\s-/ }
end
