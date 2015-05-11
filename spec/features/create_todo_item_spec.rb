require 'rails_helper'
require 'factories/user_nav'

describe "Creating todo item" do
  include UserNav

  subject(:user) { create(:user) }
  let(:todo_list) { create(:todo_list, user: user) }
  before do
    user_sign_in
    visit todo_list_path(todo_list.user, todo_list)
  end

  it "displays form to create todo item" do
    within("div.create-form") do
      expect( page ).to have_button "Create Item"
    end
  end

  context "with valid item" do

    before do
      fill_in "title", with: item.title
      click_button "Create Item"
    end

    it "displays a new list" do
      within("div.item-cont") do
        expect( page ).to have_content item.title
      end
    end

    it "displays #created_at time" do
      within("div.item-cont")do
        expect( page ).to have_content item.created_at
      end
    end
  end

  context "with invalid item" do

    before do
      fill_in "title", with: "new"
      click_button "Create Item"
    end

    it "flashes error message" do
      expect( page ).to have_content "Error saving item"
    end
  end
end 