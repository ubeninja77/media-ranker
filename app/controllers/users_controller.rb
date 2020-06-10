class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      flash[:error] = "User does not exist"
      redirect_to new_user_path
    end
  end

  def login
    username = params[:user][:username]
    user = User.find_by(username: username)
    if user 
      session[:user_id] = user.id
      flash[:success] = "You've successfully logged in as #{username}"
      return
    else
      user = User.create(username: username)
      if user.save
        session[:user_id] = user.id
        flash[:success] = "You've successfully created a new user; #{username}"
      else
        flash[:error] = "Error, username can't be left blank"
        redirect_to login_path
        return
      end
    end
    redirect_to root_path
  end

  def logout
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      unless user.nil?
        session[:user_id] = nil
        flash[:notice] = "#{user.username}, you have successfully loffed out"
      else
        session[:user_id] = nil
        flash[:error] = "An error occured while tying to logout"
      end
    else
      flash[:error] = "You must be logged in order to logout"
    end
    redirect_to root_path
  end

  def current
    @current_user = User.find_by(id: session[:user_id])
  end

  private
  def find_user
    user_id = params[:id].to_i
    @user = User.find_by(id: user_id)
  end

  def check_user
    if @user.nil?
      redirect_to users_path, error: 'User not found'
      return
    end
  end

end
