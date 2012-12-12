# encoding: utf-8
class Doc < ActiveRecord::Base
  belongs_to :person

  
  attr_accessible :docdate, :docnum, :docser, :doctype, :mr, :name_vp, :ig_doctype, :ig_docser, :ig_docnum,
		  :ig_docdate, :ig_name_vp, :ig_startdate, :ig_enddate, :docname
  
  validates :docnum, :docdate, :mr, :presence => true#, :if => :can_validate?
  validates :docnum, :docdate, :mr, :presence => {:message => "Не должно быть пустым."}
  
  validates :docser, :length => { :maximum => 10, :too_long => "%{count} символов это максимум возможного." }
  validates :docnum, :length => { :maximum => 20, :too_long => "%{count} символов это максимум возможного." }
  
  def can_validate
    true
  end
end
