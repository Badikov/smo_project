class Tipdoc < ActiveRecord::Base
  #has_many :docs, :foreign_key => :doctype
  
  attr_accessible :datebeg, :dateend, :docname, :docnum, :docser, :iddoc
end
