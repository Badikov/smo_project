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
end
