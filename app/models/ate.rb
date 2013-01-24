class Ate < ActiveRecord::Base
  has_many :nsilpus
  # has_many :ats
  self.primary_key = 'id'
  attr_accessible :id, :nameate, :nsilpu_ids
end
