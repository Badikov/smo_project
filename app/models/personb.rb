class Personb < ActiveRecord::Base
  belongs_to :person
  attr_accessible :photo, :type
end
