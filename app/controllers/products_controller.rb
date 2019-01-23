class ProductsController < ApplicationController
  before_action :set_product, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_categories, only: [:new, :edit, :create, :update]
  def index
    @products = Product.published
  end

  def show
    #set_product
  end

  def new
    @product = products_scope.new
    @product.product_images.build
  end

  def create
    @product = products_scope.new(product_params)
    if @product.save
      redirect_to dashboard_path, :notice => "Saved"
    else
      render :new
    end
  end

  def destroy
    @product.archive!
    redirect_to products_path, :notice => "Archived"
  end

  def update
    if @product.update(product_params)
      redirect_to @product, :notice => "Updated"
    else
      render :edit
    end
  end

  def publish
    @product.publish!
    User.find_each do |user|
      ProductNotifierMailer.new_product_available(@product, user).deliver
    end
    redirect_to products_path, :notice => "Published"
  end

  private

  def products_scope
    current_user.products
  end

  def set_product
    @product = Product.find_by(id: params[:id])
    redirect_to root_path, :alert => "Page not found" unless @product
  end

  def set_categories
    @categories = Category.all
  end

  def product_params
    params.require(:product).permit(:name, :description, :quantity, :price, :category_id, product_images_attributes:[:id, :image, :_destroy])
  end

end