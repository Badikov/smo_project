# encoding: utf-8
class Doc < ActiveRecord::Base
   include ActiveModel::Dirty
  belongs_to :person

  
  attr_accessible :docdate, :docnum, :docser, :doctype, :mr, :name_vp, :ig_doctype, :ig_docser, :ig_docnum, :created_at, #<<== creat - временно для переноса данных
		  :ig_docdate, :ig_name_vp, :ig_startdate, :ig_enddate, :person_id
  
  validates :docnum, :docdate, :mr, :presence => true, :if => :can_validate?
  validates :docnum, :docdate, :mr, :presence => {:message => "Не должно быть пустым."}
  
  validates :docser, :length => { :maximum => 10, :too_long => "%{count} символов это максимум возможного." }
  validates :docnum, :length => { :maximum => 20, :too_long => "%{count} символов это максимум возможного." }
  validates :name_vp, :length => { :maximum => 80, :too_long => "%{count} символов это максимум возможного." }
  validates :mr, :length => { :maximum => 100, :too_long => "%{count} символов это максимум возможного." }
  
  # before_update :save_old_data_from_doc
  # # around_update :make_feed_if_changed
  protected

  def make_feed_if_changed
    changed_ = self.changed?
    yield
    if changed_
      # make a feed
      logger.debug { "привет из документ колбэка"  }
    end
  end
  
  def can_validate?
    true
  end
  def save_old_data_from_doc
    logger.debug { "привет из документ колбэка"  }
    changed_ = self.changed?
    # yield
    if changed_
      # make a feed
      self.save_old_doc_datas
      logger.debug { "привет из документ колбэка2"  }
    end
    # doc = Doc.find_by_id(self.id)
    # unless doc.attributes == self.attributes
    #   self.save_old_doc_datas
    # end
  end
  def save_old_doc_datas
    old_doc = OldDoc.find_by_person_id(self.person_id)
    old_doc.destroy if old_doc
    doc = Doc.find_by_id(self.id)
    OldDoc.create({person_id:doc.person_id,docdate:doc.docdate, docnum:doc.docnum, docser:doc.docser, doctype:doc.doctype, mr:doc.mr, name_vp:doc.name_vp})
  end
end
