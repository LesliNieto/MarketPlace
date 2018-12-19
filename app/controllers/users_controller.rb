class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params_user)
    if @user.save
      redirect_to users_path
    else
      render :new
    end
  end

  private

  def params_user
    params.require(:user).permit(:first_name, :last_name, :email, :cellphone, :addres)
  end

end
