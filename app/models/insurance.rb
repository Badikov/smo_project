# encoding: utf-8
class Insurance < ActiveRecord::Base
  belongs_to :vizit
  has_one :polis, :dependent => :destroy
  
  attr_accessible :enp, :erp, :ogrnsmo, :ter_st, :polis,
  :polis_attributes
  
  accepts_nested_attributes_for :polis
  
  alias_method :polis=, :polis_attributes=
  
  # validates_associated :polis
  # validates :enp, :length => { :is => 16, :message => "должен быть 16 цифр" }, :allow_blank => true
end
