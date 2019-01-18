require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  login_user

  it { expect(users_path).to eq "/users" }
  it { expect(get: users_url).to route_to(
    controller: 'users',
    action: 'index' )
  }

  it { expect(user_path(1)).to eq "/users/1" }
  it { expect(get: user_url(1)).to route_to(
    controller: 'users',
    action: 'show',
    id: '1')
  }

  it { expect(dashboard_path).to eq "/dashboard" }
  it { expect(get: dashboard_url).to route_to(
    controller: 'users',
    action: 'dashboard')
  }

  it "current_user" do
    expect(subject.current_user).to_not eq(nil)
  end

  it "GET #index" do
    get :index
    expect(response).to have_http_status(:ok)
    expect(response).to render_template :index
    expect(assigns(:users)).to eq([subject.current_user])
  end

  it "GET #show" do
    get :show, params: { id: subject.current_user.id }
    expect(response).to have_http_status(:ok)
    expect(response).to render_template :show
    expect(assigns(:user)).to eq(subject.current_user)
  end

  it "DELETE #destroy" do
    expect{ delete :destroy, params: { id: subject.current_user.id } }.to change(User, :count).from(1).to(0)
    expect(response).to redirect_to root_path
  end

  describe "GET #dashboard" do

    let!(:category) { create(:category) }
    let(:product_unpublished) { create(:product, user_id: subject.current_user.id, category_id: category.id) }
    let(:product_published) { create(:product, user_id: subject.current_user.id, category_id: category.id, status: "published") }
    let(:product_archived) { create(:product, user_id: subject.current_user.id, category_id: category.id, status: "archived") }

    it "must get the user's products" do
      get :dashboard
      expect(response).to have_http_status(:ok)
      expect(response).to render_template :dashboard
      expect(subject.current_user.products).to eq [product_unpublished, product_published, product_archived]
    end

  end

end
