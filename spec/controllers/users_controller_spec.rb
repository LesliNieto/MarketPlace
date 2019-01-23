require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  login_user

  it "validate user logged" do
    expect(subject.current_user).to_not eq(nil)
  end

  describe "GET #index" do
    it "returns ok status, renders :index template and assigns the users logged" do
      get :index
      expect(response).to have_http_status(:ok)
      expect(response).to render_template :index
      expect(assigns(:users)).to eq([subject.current_user])
    end
  end

  describe "GET #show" do
    it "returns ok status, renders :show template and correctly assigns user" do
      get :show, params: { id: subject.current_user.id }
      expect(response).to have_http_status(:ok)
      expect(response).to render_template :show
      expect(assigns(:user)).to eq(subject.current_user)
    end
  end

  describe "DELETE #destroy" do
    it "delete the user of the database and redirect to root" do
      expect{ delete :destroy, params: { id: subject.current_user.id } }.to change(User, :count).from(1).to(0)
      expect(response).to redirect_to root_path
    end
  end

  describe "GET #dashboard" do

    let!(:category) { create(:category) }
    let(:product_unpublished) { create(:product, user_id: subject.current_user.id, category_id: category.id) }
    let(:product_published) { create(:product, user_id: subject.current_user.id, category_id: category.id, status: "published") }
    let(:product_archived) { create(:product, user_id: subject.current_user.id, category_id: category.id, status: "archived") }

    it "must get the products of the user who has logged in" do
      get :dashboard
      expect(response).to have_http_status(:ok)
      expect(response).to render_template :dashboard
      expect(subject.current_user.products).to eq [product_unpublished, product_published, product_archived]
    end

  end

end
