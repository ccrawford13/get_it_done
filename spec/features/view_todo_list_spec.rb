require 'rails_helper'
require 'factories/user_nav'

describe "Viewing todo_list" do
  include UserNav

  subject(:user) { create(:user) }

  before do
    user_sign_in
    visit user_todo_list_path(todo_list.user, todo_list)
  end

  let(:todo_list) { create(:todo_list, user: user) }

  context "when visited" do
    
    xit "navigates to todo_list#show" do
      click_link todo_list.title
      expect( path ).to eq(todo_list_path(user, todo_list))
    end

    it "displays todo_list #title" do
      expect( page ).to have_content todo_list.title
    end

    it "displays todo_list #created_at" do
      expect( page ).to have_content todo_list.created_at
    end
  end
end