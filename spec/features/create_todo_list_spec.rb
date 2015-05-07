require 'rails_helper'

describe "Creating todo_list" do
  before(:all) do
    Capybara.javascript_driver = :webkit
  end

  subject(:user) { create(:user) }
  let(:todo_list) { create(:todo_list, user: user) }
  before do
    user_sign_in
  end

  it "displays form to create todo_list" do
    within("div.create-form") do
      expect( page ).to have_button "Create List"
    end
  end

  context "successful completion" do
    before  do
      fill_in "title", with: todo_list.title
      click_button "Create List"
    end

    #Need clarification on utilizing JS testing here
    xit "displays new list", js: true do
      expect(response).to render_template(partial: 'todo_list')
    end

  #JS Error message flash
  context "unsuccessful creation" do
    xit "displays error message when not valid" do
      fill_in "title", with: "new"
      click_button "Create List"
      expect( page ).not_to have_content "There was an error"
    end
  end
end

def user_sign_in
  visit root_path
  click_link "Sign In"
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign In"
  visit user_path(user)
end


