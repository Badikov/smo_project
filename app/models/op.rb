class Op < ActiveRecord::Base
  belongs_to :user
  belongs_to :person
  belongs_to :filial
  
  
  attr_accessible :id, :active, :tip_op, :updated_at, :user_id, :date_uvoln, :created_at, :filial_id
  #сегодняшние новые застрахованные
  scope :new_today, -> { where(created_at: (DateTime.current.beginning_of_day)..(DateTime.current.end_of_day)) }
  scope :new_today_active, -> { new_today.where("active= ?", true) }
 
  scope :jobs_today, -> { where(updated_at: (DateTime.current.beginning_of_day)..(DateTime.current.end_of_day)) }
  
  scope :all_active, -> { where("active= ?", true) }
  # scope :all_at_date, ->(date_off) { all_active.where(["created_at < ?", date_off]).pluck(:person_id) }
  scope :all_at_date, ->(date_off) { all_active.where(["created_at < ?", date_off]) }
  
  #вчерашние новые застрахованные
  scope :new_yesterday, -> { all_active.where(created_at: (DateTime.yesterday.beginning_of_day)..(DateTime.yesterday.end_of_day)) }
  #застрахованные на введенную дату
  scope :new_date_at, ->(date_at) { all_active.where(created_at: (date_at.beginning_of_day)..(date_at.end_of_day)) }
  #вся работа на введенную дату
  scope :jobs_date_at, ->(date_at) { where(updated_at: (date_at.beginning_of_day)..(date_at.end_of_day)) }
  
  def self.count_active
    count(:all, :group => 'active')
  end
  
  
end
