class AddresG < ActiveRecord::Base
  belongs_to :person
  
  attr_accessible :bomg, :dom, :dreg, :indx, :korp, :kv, :npname, :okato, :rnname, :subj, :ul
end
