require 'rails_helper'
require 'factories/user_nav'

describe "Creating todo_list" do
  include UserNav
  Capybara.javascript_driver = :webkit
  Capybara.default_wait_time = 5
  
  subject(:user) { create(:user) }
  before do
    user_sign_in
  end
  

  it "displays form to create todo_list" do
    within("div.create-form") do
      expect( page ).to have_button "Create List"
    end
  end

  context "successful completion" do
    let(:todo_list) { create(:todo_list, user: user) }

    #Need clarification on utilizing JS testing here
    it "displays new list", js: true do
      within("div.create-form") do
        fill_in "title", with: todo_list.title
      end
      click_button "Create List"
      reload_page
      expect(page).to have_content todo_list.title
    end
  end

  #JS Error message flash
  context "unsuccessful creation" do
    let(:todo_list) { create(:todo_list, user: user) }
    it "displays error message when not valid", js: true do    
      fill_in "title", with: todo_list.title
      click_button "Create List"
      expect( page ).not_to have_content "There was an error"
    end
  end
end

