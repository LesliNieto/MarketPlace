class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    if @user.eql?(current_user)
      @user.destroy
      redirect_to users_path
    else
      redirect_to user_path, :alert => "Action not allowed"
    end
  end

end
