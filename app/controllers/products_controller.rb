class ProductsController < ApplicationController
  before_action :set_product, except: [:index, :new, :create]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
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

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :quantity, :price)
  end

end