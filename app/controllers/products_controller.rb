class ProductsController < ApplicationController
  before_action :set_product, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @products = products_scope
  end

  def new
    @product = products_scope.new
    @product.product_images.build
  end

  def create
    @product = products_scope.new(product_params)
    if @product.save
      redirect_to products_path, :notice => "Saved"
    else
      render :new
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, :notice => "Deleted"
  end

  def update
    if @product.update(product_params)
      redirect_to @product, :notice => "Updated"
    else
      render :edit
    end
  end

  private

  def products_scope
    current_user.products
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :quantity, :price, product_images_attributes:[:id, :image, :_destroy])
  end

end