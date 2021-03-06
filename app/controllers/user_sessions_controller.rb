class UserSessionsController < ApplicationController
  
  layout 'account'
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    
    
    @user_session.save do |result|
      if result
        flash[:notice] = respect_user @user_session.user.name.to_s
        redirect_to home_path
      else
        render :action => :new
      end
    end
  end   
      
      
      # flash[:notice] =  respect_user @user_session.user.name.to_s #"Login successful!"
# #       redirect_back_or_default people_path#account_url(@current_user)
#       redirect_to home_path
#     else
#       render :action => :new
#     end


  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default root_url
  end
end
