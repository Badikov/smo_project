class AddresP < ActiveRecord::Base
  belongs_to :person
  attr_accessible :dom, :indx, :korp, :kv, :npname, :okato, :rnname, :subj, :ul
end
