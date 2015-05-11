require 'rails_helper'

RSpec.describe Item, type: :model do
  
  describe "Valid Todo Item" do

    it "has a valid factory" do
      expect( create(:item) ).to be_valid
    end

    it "is invalid without a todo_list" do
      expect( build(:item, todo_list: nil) ).not_to be_valid
    end

    it "is invalid without a title" do
      expect( build(:item, title: nil) ).not_to be_valid
    end

    it "is invalid with too short of a title" do
      expect( build(:item, title: "new") ).not_to be_valid
    end
  end
end
