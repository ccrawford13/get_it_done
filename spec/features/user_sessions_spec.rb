require 'rails_helper'
require 'factories/user_nav'

  describe "User Sessions" do
    include UserNav

    context "when no user exists" do
      before do
        visit root_path
      end

      it "shows sign-up link" do
        expect( page ).to have_content "Sign Up"
      end

      it "shows sign-in link" do
        expect( page ).to have_content "Sign In"
      end

      it "doesn't show #my_lists link" do
        expect( page ).not_to have_link "My Lists"
      end

      it "doesn't show links to sign-out" do
        expect( page ).not_to have_link "Sign Out"
      end
    end

    context "when user exists" do
      subject(:user) { create(:user) }
      before do
        user_sign_in
        visit root_path
      end

      it "shows #my_lists link" do
        expect( page ).to have_link "My Lists"
      end

      it "shows links to sign-out" do
        expect( page ).to have_link "Sign Out"
      end

      it "doesn't show link to sign-up" do
        expect( page ).not_to have_content "Sign Up"
      end

      it "doesn't show link to sign-in" do
        expect( page ).not_to have_content "Sign In"
      end
    end
  end

  describe "User sign-in" do
    include UserNav
    subject(:user) { create(:user) }
    
    context "successful sign-in" do

      it "redirects to users#show" do
        user_sign_in
        expect( current_path ).to eq (user_path(user))
      end

      it "flashes confirmation message" do
        user_sign_in
        expect( page ).to have_content "Signed in successfully"
      end
    end

    context "unsuccessful sign-in" do
      before do
        visit root_path
        click_link "Sign In"
      end

      it "requires confirmed user" do
        user.update_attributes(confirmed_at: nil)
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Sign In"
        expect( page ).to have_content "You have to confirm your email address before continuing"
      end

      it "requires correct email" do
        fill_in "Email", with: "notuseremail"
        fill_in "Password", with: user.password
        click_button "Sign In"
        expect( page ).to have_content "Invalid email or password"
      end

       it "requires correct password" do
        fill_in "Email", with: user.email
        fill_in "Password", with: "notuserpassword"
        click_button "Sign In"
        expect( page ).to have_content "Invalid email or password"
      end
    end
  end

  describe "User sign-out" do
    include UserNav
    let(:user) { create(:user) }
    before do
      user_sign_in
    end

    # User sign out using Index page button
    it "redirects to root_path" do
      visit root_path
      user_sign_out_index
      expect( current_path ).to eq root_path
    end

    # User sign out using navbar dropdown
    it "allows user to sign out using dropdown" do
      user_sign_out_navbar
      expect( current_path ).not_to eq user_path(user)
    end
  end