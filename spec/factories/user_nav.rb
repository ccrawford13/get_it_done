module UserNav


# Helper methods to DRY up feature tests

  # User Sign In 
  def user_sign_in(user)
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
  end

  # Sign out user utilizing buttons on #index
  def user_sign_out_index
    visit root_path
    within(".button-container") do
      click_link "Sign Out"
    end
  end

  # Sign out user utilizing dropdown in navbar
  def user_sign_out_navbar
    visit root_path
    within(".dropdown") do
      click_link "Sign Out"
    end
  end
end