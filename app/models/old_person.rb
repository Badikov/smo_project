class OldPerson < ActiveRecord::Base
  belongs_to :person
  attr_accessible :dr, :fam, :im, :old_enp, :ot, :w
end
