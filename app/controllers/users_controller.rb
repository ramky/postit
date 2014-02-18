class UsersController < ApplicationController

  def index

  end

  def show

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "You are registered now."
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

private
  def set_user
    @user = Post.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end  
end