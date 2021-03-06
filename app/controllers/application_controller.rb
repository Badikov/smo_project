# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  
   # check_authorization  # проверка авторизации и доступа на всех экшенах всех контроллеров

  helper_method :current_user_session, :current_user
#   before_filter :set_current_user
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  def respect_user(user)
    fio =[]
    res, hel =""
    fio = user.split(" ")
    # fio.shift
    fio.each_with_index {|v,i| res += v+' ' if i>0}
    now = Time.current.hour
    if (0..5).include?(now)
      hel = 'Доброй ночи, '
    elsif (6..11).include?(now)
      hel = 'Доброе утро, '
    elsif (12..17).include?(now)
      hel = 'Добрый день, '
    elsif (18..23).include?(now)
      hel = 'Добрый вечер, '
    end
    logger.debug now
    return hel + res
  end

  private
  
  
  
    def current_user_session
      
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end

    def require_user
      logger.debug "ApplicationController::require_user"
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to login_url
        return false
      end
    end

    def require_no_user
      logger.debug "ApplicationController::require_no_user"
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
       # redirect_to home_index_path
        return false
      end
    end

    def store_location
      session[:return_to] = request.fullpath
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
    def minus_5(str)
        len = str.size - 5
        resp_str = str.slice(0..len)
      return resp_str
    end
    def day_to_str(str)
      day_str =""
      if str.size == 1
        day_str = "0" + str 
      else
        day_str = str
      end
      return day_str
    end
end
