require 'rails_helper'
RSpec.describe Product, :type => :model do
  describe "#Create" do

    context "When a product has been created via a factory" do
      let(:product) { create(:product) }
      it "is valid with name, description, quantity, price, cateogry_id, user_id" do
        expect(product).to be_persisted
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
      let!(:unpublished_product) { create(:product) }
      let!(:published_product) { create(:product, status: "published") }
      let!(:archived_product) { create(:product, status: "archived") }

      it "should get the unpublished products" do
        expect(Product.unpublished).to contain_exactly(unpublished_product)
      end

      it "should get the published products" do
        expect(Product.published).to contain_exactly(published_product)
      end

      it "should get the archived products" do
        expect(Product.archived).to contain_exactly(archived_product)
      end
    end

    context "NestedAttributes" do
      it { should accept_nested_attributes_for :product_images }
    end
  end
end
