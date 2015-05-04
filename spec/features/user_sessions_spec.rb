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

      xit "#home page should be users#show" do
        expect( current_path ).to eq(users(current_user))
      end

      xit "shows sign-out link" do
        expect( page ).to have_content "Sign Out"
      end

      it "sign-up navigates to sign-up page" do
        click_button "Sign Up"
        expect( current_path ).to eq(new_user_registration_path)
      end
    end
  end

  describe "User sign up" do
    before do
      visit root_path
      click_link "Sign Up"
    end

    context "successful sign up" do
      it "is valid with correct credentials" do
        sign_up_credentials
        expect( page ).to have_content "Welcome"
        expect( current_path).to eq "users"
      end

      it "sends confirmation email" do
        sign_up_credentials
        expect( page ).to have_content "A message with a confirmation link has been sent"
      end
    end

    context "unsuccessful sign up" do
      it "requires first name" do
        fill_in "Last name", with: "Smith"
        fill_in "Email", with: "john@example.com"
        fill_in "Password", with: "helloworld"
        fill_in "Password confirmation", with: "helloworld"
        click_button "Sign Up"
        expect( page ).to have_content "First name can't be blank"
      end

      it "requires last name" do
        fill_in "First name", with: "John"
        fill_in "Email", with: "john@example.com"
        fill_in "Password", with: "helloworld"
        fill_in "Password confirmation", with: "helloworld"
        click_button "Sign Up"
        expect( page ).to have_content "Last name can't be blank"
      end

      it "requires valid email" do
        fill_in "Email", with: "john@example"
        fill_in "Password", with: "helloworld"
        fill_in "Password confirmation", with: "helloworld"
        click_button "Sign Up"
        expect( page ).to have_content "Email is invalid"
      end

      it "requires valid password" do
        fill_in "Email", with: "john@example.com"
        fill_in "Password", with: "world"
        fill_in "Password confirmation", with: "world"
        click_button "Sign Up"
        expect( page ).to have_content "Password is too short"
      end

      it "requires matching passwords" do
        fill_in "Email", with: "john@example.com"
        fill_in "Password", with: "hellowor"
        fill_in "Password confirmation", with: "helloworld"
        click_button "Sign Up"
        expect( page ).to have_content "Password confirmation doesn't match Password"
      end
    end
  end

def sign_up_credentials
  fill_in "First name", with: "John"
  fill_in "Last name", with: "Smith"
  fill_in "Email", with: "john@example.com"
  fill_in "Password", with: "helloworld"
  fill_in "Password confirmation", with: "helloworld"
  click_button "Sign Up"
end





    



