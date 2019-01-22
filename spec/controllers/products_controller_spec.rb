require 'rails_helper'
RSpec.describe ProductsController, :type => :controller do
  login_user

  let(:product1) { create(:product, status: "published", user_id: subject.current_user.id) }

  describe "GET #index" do
    it 'returns ok status, renders :index template and correctly assigns products' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(response).to render_template :index
      expect(assigns(:products)).to eq([product1])
    end
  end

  describe "GET #show" do
    it "returns ok status,correctly assigns products and renders :show template" do
      get :show, params: { id: product1.to_param }
      expect(response).to have_http_status(:ok)
      expect(assigns(:product)).to eq(product1)
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    it "returns ok status,correctly assigns to be a new product and renders :new template" do
      get :new, params: { }
      expect(response).to have_http_status(:ok)
      expect(assigns(:product)).to be_a_new(Product)
      expect(response).to render_template :new
    end
  end

  describe "GET #create" do
    it "is created with the required fields" do
      product_attributes = {
        product: FactoryBot.attributes_for(:product)
      }
      expect{ post :create, { params: product_attributes } }.to change( Product, :count ).by(1)
      expect(response).to redirect_to products_path
    end

    it "renders an error because of missing required fields" do
      product_attributes = {
      product: FactoryBot.attributes_for(:product, name: nil)
      }
      expect{ post :create, { params: product_attributes } }.to_not change( Product, :count )
      expect(response).to render_template :new
    end
  end

  describe "GET #edit" do
    it "returns ok status,correctly assigns products and renders :edit template" do
      get :edit, params: { id: product1.to_param }
      expect(response).to have_http_status(:ok)
      expect(assigns(:product)).to eq(product1)
      expect(response).to render_template :edit
    end
  end

  describe "PUT #update" do
    it "updates with all required fields, verify that the field was updated and redirect to product1" do
      put :update, params: { id: product1, product: { name: 'New name' } }
      product1.reload
      expect(product1.name).to eq("New name")
      expect(response).to redirect_to product1
    end

    it "renders an error because of missing fields required" do
      put :update, params: { id: product1, product: { name: nil } }
      expect(response).to render_template :edit
    end

    let(:unpublished_product) { create(:product) }

    it "updates status to published" do
      put :publish, params: { id: unpublished_product, product: { status: 'published' } }
      unpublished_product.reload
      expect(Product.published).to contain_exactly(unpublished_product)
      expect(response).to redirect_to products_path
    end
  end

  describe "DELETE #destroy" do
    it "updates the status of the product to be archived and redirects to the products_path" do
      delete :destroy, params: { id: product1, product: { status: 'archived' } }
      product1.reload
      expect(Product.archived).to contain_exactly(product1)
      expect(response).to redirect_to products_path
    end
  end
end
