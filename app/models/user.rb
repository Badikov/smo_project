class User < ActiveRecord::Base
    
  # has_many :filializations
  # has_many :filials, :through => :filializations
  belongs_to :filial
  has_many :ops
  
  validates_presence_of :name, :login, :email, :filial_id, :role_ids #, :password
  validates_uniqueness_of :name,:login, :email, :case_sensitive => false
  
  acts_as_authentic do |c|
    c.login_field       = 'email'
    c.logged_in_timeout = 30.minutes # default is 10.minutes
  end # block optional
  
  simple_roles
  
  attr_accessible :name, :password, :password_confirmation, :login, :email, :filial_id, :role_ids,
                  :failed_login_count
end