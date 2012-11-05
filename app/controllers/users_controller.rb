# encoding: utf-8
class UsersController < ApplicationController
  
  before_filter :require_user, :only => [:show, :edit, :update]
  
  def index
    @users = User.all
#      authorize! :read, @users
  end
  def new
    @user = User.new
  end

  def create
    #TODO!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#     params[:user][:login] = 
#     params[:user][:email] = 'badikov-a@yandex.ru'
    @user = User.new(params[:user])

    # Saving without session maintenance to skip
    # auto-login which can't happen here because
    # the User has not yet been activated
    if @user.save
      flash[:notice] = "Новый пользователь успешно добавлен."
      redirect_to home_path#signup_url
    else
      flash[:notice] = "There was a problem creating you."
      render :action => :new
    end

  end
  # GET /users/current
  def show
    @user = current_user
  end
  # GET /users/1/edit
  def edit
    params.include?([:id]) ? @user = User.find(params[:id]) : @user = current_user
    
  end

  def update
    @user = User.find(params[:id]) #current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Акаунт обнавлен!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
end
