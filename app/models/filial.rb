class Filial < ActiveRecord::Base
  has_many :filializations
  has_many :users, :through => :filializations
  
  attr_accessible :title
end
