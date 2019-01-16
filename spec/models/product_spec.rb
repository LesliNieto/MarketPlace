require 'rails_helper'
RSpec.describe Product, :type => :model do
  before(:each) do
    @product1 = create(:product)
    @product2 = create(:product, status: "published")
    @product3 = create(:product, status: "archived")
  end

  describe "#Create" do

    context "When a product has been created " do
      it "is valid with name, description, quantity, price, cateogry_id, user_id" do
        expect(@product1).to be_persisted
      end
    end

    context "Validations" do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:description) }
      it { should validate_presence_of(:quantity) }
      it { should validate_presence_of(:price) }
      it { should validate_presence_of(:category_id) }
      it { should validate_presence_of(:user_id) }
    end

    context "Associations" do
      it { should belong_to(:user) }
      it { should belong_to(:category) }
      it { should have_many(:product_images).dependent(:destroy) }
    end

    context "Scopes" do
      it "should get the unpublished products" do
        expect(@product1.status).to eql("unpublished")
      end

      it "should get the published products" do
        expect(@product2.status).to eql("published")
      end

      it "should get the archived products" do
        expect(@product3.status).to eql("archived")
      end
    end

    context "NestedAttributes" do
      it { should accept_nested_attributes_for :product_images }
    end
  end
end
