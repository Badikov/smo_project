class User < ActiveRecord::Base
  has_many :assignments
  has_many :roles, :through => :assignments
  
  has_many :filializations
  has_many :filials, :through => :filializations
  
  has_many :ops
  
  acts_as_authentic do |c|
     c.login_field = 'email'
  end # block optional
  
  def role_symbols
    (roles || []).map {|r| r.title.to_sym}
  end

  attr_accessible :name, :password, :password_confirmation, :login, :email, :filial_ids, :role_ids, :title
end
