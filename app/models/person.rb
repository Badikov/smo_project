# encoding: utf-8
class Person < ActiveRecord::Base
  
  has_one :doc#, :dependent => :destroy
  has_one :old_person#, :dependent => :destroy
  has_one :old_doc#, :dependent => :destroy
  has_one :addres_g#, :dependent => :destroy
  has_one :addres_p#, :dependent => :destroy
  has_one :op#, :dependent => :destroy
  has_one :vizit#, :dependent => :destroy
  has_one :personb#, :dependent => :destroy
  has_many :ats
  has_one :representative#, :dependent => :destroy
    
  attr_accessible :c_oksm, :ddeath, :dr, :id,
  :email, :fam, :im, :ot, :phone, :ss, :true_dr, :w,:status, :created_at, #<<== creat - временно для переноса данных
	:representative, :doc, :addres_g, :addres_p,
  :doc_attributes, :addres_g_attributes, :addres_p_attributes, :representative_attributes,
  :op_attributes, :vizit_attributes, :personb_attributes, :ats_attributes
  
  accepts_nested_attributes_for :doc, :old_person, :old_doc, :addres_g, :addres_p, :op, :vizit, :representative
  
  alias_method :doc=, :doc_attributes=
  alias_method :addres_g=, :addres_g_attributes=
  alias_method :addres_p=, :addres_p_attributes=
  alias_method :representative=, :representative_attributes=
  
 
  
  
  validates :fam, :im, :ot, :w, :c_oksm, :status, :dr, :presence => true, :if => :can_validate?
  validates :fam, :im, :ot, :w, :c_oksm, :status, :dr, :presence => {:message => "Не должно быть пустым."}
  validates :fam, :im, :ot, :length => { :maximum => 40, :too_long => "%{count} символов это максимум возможного." }
  validates :phone, :length => { :maximum => 40, :too_long => "%{count} символов это максимум возможного." }, :allow_blank => true
  validates :c_oksm, :length => { :is => 3 }
  validates :ss, :length => { :is => 14 }, :allow_blank => true
  validates :email, :length => { :maximum => 50, :too_long => "%{count} символов это максимум возможного." }, :allow_blank => true
  validates :ss, :format => { :with => /^\d{3}-\d{3}-\d{3}(-|\s)\d{2}$/ , :message => "не соответствует шаблону"}, :allow_blank => true
  
  validates_associated :doc, :addres_g, :addres_p, :representative
  
  # before_validation :set_person_age_18
  before_update :save_old_data
  
  protected
  # def set_person_age_18
  #   self.representative.person_age_18 = self.dr.advance(:years => 18)
  # end
  
  def can_validate?
    true
  end
  
  def save_old_data
    logger.debug { "привет из персон колбэка"  }
    changed_ = self.changed?
    # yield
    if changed_
      self.save_old_data_of_person
    end
  end
  
  def save_old_data_of_person
    old_per = OldPerson.find_by_person_id(self.id)
    old_per.destroy if old_per
    person = Person.find_by_id(self.id)
    # OldPerson.create()
    self.create_old_person({fam: person.fam, im: person.im, ot: person.ot, w: person.w, dr: person.dr, old_enp: person.vizit.insurance.enp})
  end
  
  # def save_old_recvisites_of_person
  #   self.save_old_data_of_person
  #   old_doc = OldDoc.find_by_person_id(self.id)
  #   old_doc.destroy if old_doc
  #   self.create_old_doc({docdate:self.doc.docdate, docnum:self.doc.docnum, docser:self.doc.docser, doctype:self.doc.doctype, mr:self.doc.mr, name_vp:self.doc.name_vp})
  # end
end
