# encoding: utf-8
class UserSession < Authlogic::Session::Base
  
  # validates :email, :password, :presence => true
  # specify configuration here, such as:
  logout_on_timeout true
  consecutive_failed_logins_limit 10 #лимит попыток залогиниться
  # ...many more options in the documentation
  # before_validation :check_if_awesome
  # # 
  # private
  #   def check_if_awesome
  #     errors.add(:email, "email должен содержать знак @") if email && !email.include?("@")
  #     errors.add(:base, "You must be awesome to log in") unless attempted_record.awesome?
  #   end
end
