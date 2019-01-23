class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :destroy, :dashboard]

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    redirect_to root_path, :alert => "Page not found" unless @user
  end

  def destroy
    current_user.destroy
    redirect_to root_path
  end

  def dashboard
    @products_published = products_scope.published
    @products_unpublished = products_scope.unpublished
    @products_archived = products_scope.archived
  end

  private

  def products_scope
    current_user.products
  end

end
