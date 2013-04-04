# encoding: utf-8
class Polis < ActiveRecord::Base
  belongs_to :insurance, :include => :vizit
  
  attr_accessible :dbeg, :dend, :dstop, :npolis, :spolis, 
                  :vpolis, :datepolis, :datepp, :insurance_id, 
                  :created_at #<<== creat - временно для переноса данных
    
  validates :npolis, 
            :format => { :with => /^\d{6,}$/ , :message => "должны быть только цифры"}, :allow_blank => false
  validates :spolis, 
            :length => { :is => 3 }, :allow_blank => true, :format => { :with => /^\d{3}$/ , :message => "должны быть только 3 цифры"}
  
  validates_each :npolis do |record, attr, value|
    # if record.datepp.blank?
        if record.spolis.blank?
          record.errors.add(attr, 'длинна номера бланка полиса 11 цифр') if value.size != 11
        else
          record.errors.add(attr, 'длинна номера временного свидетельства 6 цифр') if value.size != 6
          record.errors.add(attr, 'номер временного свидетельства введен не правильно.') unless record.check_numbers?
        end
      # end
  end
  # after_validation :foo_val
  before_create :data_logic
  # before_save :data_logic
  before_update :data_logic, :if => :check_changed? 
  def foo
      return @foo
  end
  def foo=(value)
      @foo = value
  end
  def check_numbers?
      directory = "public/numbers"
      name = "numbers.ini"
      path = File.join(directory, name)
      ini_file = IniFile.load(path).to_h
      flag = false
      ini_file.values.each do |line|
        if line["start"].upto(line["end"]).to_a.include?(self.npolis) and line["series"] == self.spolis
          # проверяем, нет ли уже в базе этой серии-номера
          _polis = Polis.find_by_spolis_and_npolis(self.spolis, self.npolis)
          flag = true unless _polis
        end
      end
      if flag
        logger.debug { "серия - номер: true"  }
        true
      else
        logger.debug { "серия - номер: false"  }
        false
      end
  end
  
  protected
  def check_changed?
    logger.debug {'changed.size ----->' + self.changed.size.to_s }
    if self.changed.size >= 2 and self.changed.size < 5
      true
    else
      false
    end
  end
    
  def data_logic
    logger.debug { "привет из полиса"  }
    self.dbeg_dend_and_vpolis
  end
  def dbeg_dend_and_vpolis
    self.dbeg = self.insurance.vizit.dvizit #дата начала действия документа страхования
    # if self.insurance.erp == 0 || (self.insurance.erp == 1 and self.insurance.vizit.rpolis >= 1) 
    if self.insurance.erp == 0 || (self.insurance.erp == 1 and self.foo > 0) 
    # или не зарегестрирован в ЕНП(первичный выбор СМО)
    # или зарегестрирован и меняет полис(rpolis > 0 )
      self.dend = self.dbeg + 42.day
      self.vpolis = 2
    else
      self.vpolis = 3
    end
    self.spolis = nil if self.spolis.blank?
    self.datepp = nil if self.datepp?
  end
  
  def polis_data_for_doublecat
    # przcod, id_fl, tip_op, status, fam, im, ot, w, dr, kod, ss, phone, email, fam_pr, im_pr, ot_pr, parents, ser_pr, nom_pr, dat_pr, typ_pr, tel_pr, ddeath, doctype, docser, docnum, docdate, name_vp, mr, bomg, kod_tf, indx, okato, npname, ul, dom, korp, kv, dreg, dvizit, method, petition, rsmo, rpolis, fpolis, ter_st, ogrnsmo, enp, erp, vpolis, spolis, npolis, dbeg, dend, dstop, date_polis, datepp, date_uvoln, date_modif
  end
end
