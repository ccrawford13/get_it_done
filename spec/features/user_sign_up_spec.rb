require 'rails_helper'

describe "User sign up" do
  before do
    visit root_path
    click_link "Sign Up"
  end

  context "successful sign up" do
    it "redirects to root_path" do
      sign_up_credentials
      expect( current_path).to eq root_path
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