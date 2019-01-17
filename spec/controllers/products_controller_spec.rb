require 'rails_helper'
RSpec.describe ProductsController, :type => :controller do
  login_user

  it { expect(products_path).to eq '/products' }
  it { expect(get: products_url).to route_to(
    controller: 'products',
    action: 'index' )
  }

  it { expect(product_path(1)).to eq '/products/1' }
  it { expect(get: product_url(1)).to route_to(
    controller: 'products',
    action: 'show',
    id: '1' )
  }

  it { expect(new_product_path).to eq '/products/new' }
  it { expect(get: new_product_url).to route_to(
    controller: 'products',
    action: 'new' )
  }

  it { expect(edit_product_path(1)).to eq '/products/1/edit' }
  it { expect(get: edit_product_url(1)).to route_to(
    controller: 'products',
    action: 'edit',
    id: '1' )
  }

  it { expect(publish_product_path(1)).to eq '/products/1/publish' }
  it { expect(put: publish_product_url(1)).to route_to(
    controller: 'products',
    action: 'publish',
    id: '1' )
  }

  let(:product1) { create(:product, status: "published", user_id: subject.current_user.id) }

  it "GET #index" do
    get :index
    expect(response).to have_http_status(:ok)
    expect(response).to render_template :index
    expect(assigns(:products)).to eq([product1])
  end

  it "GET #show" do
    get :show, params: { id: product1.to_param }
    expect(response).to have_http_status(:ok)
    expect(assigns(:product)).to eq(product1)
    expect(response).to render_template :show
  end

  it "GET #new" do
    get :new, params: { }
    expect(assigns(:product)).to be_a_new(Product)
    expect(response).to render_template :new
  end

  describe "GET #create" do

    it "created with the required fields" do
      product_attributes = {
        product: FactoryBot.attributes_for(:product)
      }
      expect{ post :create, { params: product_attributes } }.to change( Product, :count ).by(1)
      expect(response).to redirect_to products_path
    end

    it "missing required fields" do
      product_attributes = {
      product: FactoryBot.attributes_for(:product, name: nil)
      }
      expect{ post :create, { params: product_attributes } }.to_not change( Product, :count )
      expect(response).to render_template :new
    end
  end

  it "GET #edit" do
    get :edit, params: { id: product1.to_param }
    expect(response).to have_http_status(:ok)
    expect(assigns(:product)).to eq(product1)
    expect(response).to render_template :edit
  end

  describe "PUT #update" do

    it "Update with all required fields" do
      put :update, params: { id: product1, product: { name: 'New name' } }
      product1.reload
      expect(product1.name).to eq("New name")
      expect(response).to redirect_to product1
    end

    it "update without required fields" do
      put :update, params: { id: product1, product: { name: nil } }
      expect(response).to render_template :edit
    end

    let(:unpublished_product) { create(:product) }

    it "update status to published" do
      put :publish, params: { id: unpublished_product, product: { status: 'published' } }
      unpublished_product.reload
      expect(Product.published).to contain_exactly(unpublished_product)
      expect(response).to redirect_to products_path
    end
  end

  it "DELETE #destroy" do
    delete :destroy, params: { id: product1, product: { status: 'archived' } }
    product1.reload
    expect(Product.archived).to contain_exactly(product1)
    expect(response).to redirect_to products_path
  end

end