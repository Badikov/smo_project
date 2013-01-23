class Ate < ActiveRecord::Base
  has_many :nsilpus
  has_many :ats
  attr_accessible :kdate, :nameate, :kdates
end
