require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) do
    @user1 = create(:user)
    @user2 = User.create_form_provider_data(RecursiveOpenStruct.new(OmniAuth::config.mock_auth[:facebook]))
    @user3 = User.create_form_provider_data(RecursiveOpenStruct.new(OmniAuth::config.mock_auth[:google]))
  end

  describe "Associations" do
    it { should have_many(:products).dependent(:destroy) }
  end

  describe "Nested attributes" do
    it { should accept_nested_attributes_for(:products) }
  end

  describe "#Create" do

    describe "When creating a user" do
      it "must respond positively" do
        expect(@user1).to be_valid
      end

      it "validates that the user is created" do
        expect(@user1.last_name).to eql("Test")
      end
    end

    describe "when creating a user without the fields required" do

      it { should validate_presence_of(:first_name) }
      it { should validate_presence_of(:last_name) }
      it { should validate_presence_of(:email) }
      it { should validate_presence_of(:password)}
      
      it "is invalid when enter an email that is already in use" do
        user = build(:user, email: "test@gmail.com")
        user.valid?
        expect(user.errors[:email]).to include("has already been taken")
      end

      it "is invalid when enter a  different password confirmation" do
        user = build(:user, password: "123456789", password_confirmation: "789456123")
        user.valid?
        expect(user.errors[:password_confirmation]).to include("doesn't match Password")
      end

      it "is invalid when enter a password too short" do
        user = build(:user, password: "123456")
        user.valid?
        expect(user.errors[:password]).to include("is too short (minimum is 8 characters)")
      end
    end

    describe "#Login facebook" do
      it "data provider" do
        expect(@user2).to be_persisted
      end

      it "validates if user is create" do
        expect(@user2.first_name).to eql("Joe")
      end
    end

    describe "#Login google" do
      it "data provider" do
        expect(@user3).to be_persisted
      end

      it "validates if user is create" do
        expect(@user3.first_name).to eql("Laura")
      end
    end

  end

end
