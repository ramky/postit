class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update]
  def show

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "You are registered and logged in now."
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your profile was updated."
      redirect_to root_path      
    else
      render :edit
    end    
  end

private
  def set_user
    @user = User.find_by(username: params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password, :timezone)
  end  

  def require_same_user
    if current_user != @user
      flash[:error] = 'You are not authorized to complete this action.'
      redirect_to root_path
    end
  end
end