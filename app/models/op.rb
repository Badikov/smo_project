class Op < ActiveRecord::Base
  belongs_to :user
  belongs_to :person
  
  
  attr_accessible :id, :active, :tip_op, :updated_at, :user_id, :date_uvoln, :created_at
  
  scope :new_today, -> { where(created_at: (DateTime.current.beginning_of_day - 1.day)..(DateTime.current.end_of_day)) }
  scope :new_today_active, -> { new_today.where("active= ?", true) }
 
  
  # self.primary_key = "person_id"#"id" #
  
  # before_update :save_id_for_terfond
  
  protected
  def save_id_for_terfond
    self.id = self.person_id
  end
  
end
