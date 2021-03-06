class Foreigner < ActiveRecord::Base
  belongs_to :person
   attr_accessible :ig_doctype,:ig_docser,:ig_docnum,:ig_docdate,:ig_name_vp,:ig_startdate,:ig_enddate,:person_id
  
  def self.all_foreigners
    includes(:person => {:op => :user}).joins(:person => :op).where('ops.active = ?', true)
  end
end
