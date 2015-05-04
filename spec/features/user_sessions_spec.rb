require 'rails_helper'

  describe "User Sessions" do
    before do
      visit root_path
    end

    context "when no user exists" do

      it "shows sign-up link" do
        expect( page ).to have_content "Sign Up"
      end

      it "shows sign-in link" do
        expect( page ).to have_content "Sign In"
      end
    end

    context "when user exists" do
      subject(:user) { create(:user) }
      before do
        click_link "Sign In"
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Sign In"
      end

      it "shows #my_lists link" do
        # Sign in Redirects to user_path(user)
        visit root_path
        expect( page ).to have_link "My Lists"
      end

      it "shows link to sign-out" do
        visit root_path
        expect( page ).to have_link "Sign Out"
      end

      it "hides link to sign-up" do
        expect( page ).not_to have_content "Sign Up"
      end

      it "hides link to sign-in" do
        expect( page ).not_to have_content "Sign In"
      end
    end
  end

  describe "User sign-in" do
    subject(:user) { create(:user) }
    before do
      visit root_path
      click_link "Sign In"
    end

    context "successful sign-in" do

      it "redirects to users#show" do
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Sign In"
        expect( current_path ).to eq (user_path(user))
      end
    end

    context "unsuccessful sign-in" do

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
    let(:user) { create(:user) }
    before do
      visit root_path
      click_link "Sign In"
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Sign In"
    end

    it "redirects to root_path" do
      visit root_path
      click_link "Sign Out"
      expect( current_path ).to eq root_path
    end
  end