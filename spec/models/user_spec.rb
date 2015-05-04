require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe "Valid User" do

    it "has a valid factory" do
      expect( create(:user) ).to be_valid
    end

    it "is invalid without a first_name" do
      expect( build(:user, first_name: nil) ).not_to be_valid
    end

    it "is invalid without a last_name" do
      expect( build(:user, last_name: nil) ).not_to be_valid
    end

    it "is invalid without an email" do
      expect( build(:user, email: nil) ).not_to be_valid
    end

    it "is invalid without password confirmation" do
      expect( build(:user, password_confirmation: nil) ).not_to be_valid
    end
  end
end
