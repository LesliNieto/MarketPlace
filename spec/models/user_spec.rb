require 'rails_helper'

RSpec.describe User, type: :model do

  describe "Associations" do
    it { should have_many(:products).dependent(:destroy) }
  end

  describe "Nested attributes" do
    it { should accept_nested_attributes_for(:products) }
  end

  describe "Validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password)}
    
    context 'duplicated emails' do
      let!(:user) { create(:user, email: "test@gmail.com") }
      
      it "is invalid when enter an email that is already in use" do
        user = build(:user, email: "test@gmail.com")
        user.valid?
        expect(user.errors[:email]).to include("has already been taken")
      end
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

  describe "#Create" do

    describe "When creating an user via the 'user' factory" do
      let(:user) { create(:user) }
      
      it "must respond positively" do
        expect(user).to be_valid
      end

      it "validates that the user is created" do
        expect(user.last_name).to eql("Test")
      end
    end

    describe "#Login facebook" do
      let(:user) { User.create_form_provider_data(RecursiveOpenStruct.new(OmniAuth::config.mock_auth[:facebook])) }

      it "data provider" do
        expect(user).to be_persisted
      end

      it "validates if user is create" do
        expect(user.first_name).to eql("Joe")
      end
    end

    describe "#Login google" do
      let(:user) { User.create_form_provider_data(RecursiveOpenStruct.new(OmniAuth::config.mock_auth[:google])) }

      it "data provider" do
        expect(user).to be_persisted
      end

      it "validates if user is create" do
        expect(user.first_name).to eql("Laura")
      end
    end

  end

end