class UserSession < Authlogic::Session::Base
  # specify configuration here, such as:
  logout_on_timeout true
  consecutive_failed_logins_limit 10 #лимит попыток залогиниться
  # ...many more options in the documentation
  # before_validation :check_if_awesome
  # 
  # private
  #   def check_if_awesome
  #     errors.add(:email, "must contain awesome") if email && !email.include?("awesome")
  #     errors.add(:base, "You must be awesome to log in") unless attempted_record.awesome?
  #   end
end
