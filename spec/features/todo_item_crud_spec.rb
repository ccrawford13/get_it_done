require 'rails_helper'

describe "Todo item crud" do
  Capybara.javascript_driver = :webkit

  subject(:user) { create(:user) }
  let(:todo_list) { create(:todo_list, user: user) }
  let(:item) { create(:item, todo_list: todo_list) }

  before do
    login_as(user, scope: :user)
    visit user_todo_list_path(user, todo_list)
  end

  describe "Creating todo item" do
    
    it "displays form to create todo item" do
      expect( page ).to have_selector(:link_or_button, "Create Item")
    end

    context "successful creation" do

      before do
        fill_in "title", with: item.title
        click_button "create_item" 
      end

      it "displays new item", js: true do
        expect( page ).to have_content item.title.upcase
      end

      it "displays #created_at time", js: true do
        expect( page ).to have_content item.created_at
      end
    end

    context "unsuccessful creation" do

      it "displays error with too short title", js: true do
        fill_in "title", with: "new"
        click_button "create_item"
        expect( page ).to have_content "Error Creating Item. Please Try Again"
      end
    end
  end

  describe "Marking todo item as #complete" do
    before do
      fill_in "title", with: item.title
      click_button "create_item"
    end

    it "displays link to mark as #complete", js: true do
      expect( page ).to have_selector(:link_or_button, "mark_complete")
    end

    it "renders item as #completed", js: true do
      click_button "mark_complete"

      within(".incomplete-items") do
        expect( page ).not_to have_content item.titl
      end
    end
  end
end
#   describe "Deleting todo item" do

#     before do
#       fill_in "title", with: item.title
#       click_button "create_item"
#     end

#     it "displays link to delete item", js: true do
#       expect( page ).to have_selector(".delete-item")
#     end

#     it "removes list", js: true do
#       click_link "delete_item"
#       expect( page ).not_to have_content item.title
#     end
#   end
# end