require 'rails_helper'
require 'factories/user_nav'

describe "Creating todo_list" do
  include UserNav
  Capybara.javascript_driver = :webkit
  
  subject(:user) { create(:user) }

  before do
    login_as(user, scope: :user)
    visit user_path(user)
  end
  
  
  it "displays form to create todo_list" do
    expect( page ).to have_selector(:link_or_button, "Create List")
  end

  context "successful creation" do
    let(:todo_list) { create(:todo_list, user: user, title: "New List") }

    before do
      fill_in "title", with: todo_list.title
      click_button "create_list"
    end

    it "displays new list", js: true do
      expect( page ).to have_content todo_list.title.upcase # Font is set to upcase
    end

    it "displays #created_at time", js: true do
      expect( page ).to have_content todo_list.created_at
    end
  end

  context "unsuccessful creation" do

    let(:todo_list) { create(:todo_list, user: user) }
    
    it "displays error with too short title", js: true do    
      fill_in "title", with: "New"
      click_button "create_list"
      expect( page ).to have_content "Error Creating List. Please Try Again"
    end
  end
end

describe "Destroying todo_list" do

  subject(:user) { create(:user) }
  let(:todo_list) { create(:todo_list, user: user, title: "New List") }

  before do
    login_as(user, scope: :user)
    visit user_path(user)
    fill_in "title", with: "New list"
    click_button "create_list"
  end

  it "displays link to delete todo_list", js: true do
    expect( page ).to have_selector(".delete-item")
  end

  it "removes list", js: true do
    click_link "delete_list"
    expect( page ).not_to have_content todo_list.title
  end
end