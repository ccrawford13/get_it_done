require 'rails_helper'

RSpec.describe TodoList, type: :model do
  
  describe "Valid TodoList" do

    it "has a valid factory" do
      expect( create(:todo_list) ).to be_valid
    end

    it "is invalid without a user" do
      expect( build(:todo_list, user: nil) ).not_to be_valid
    end

    it "is invalid without a title" do
      expect( build(:todo_list, title: nil) ).not_to be_valid
    end

    it "is invalid with too short of a title" do
      expect( build(:todo_list, title: "new") ).not_to be_valid
    end
  end
end
