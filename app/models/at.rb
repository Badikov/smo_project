class At < ActiveRecord::Base
  belongs_to :person
  attr_accessible :date_b, :date_e, :date_z, :kdatemu, :kdmu, :type
end
