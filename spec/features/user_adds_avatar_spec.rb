
require "rails_helper"

feature "upload an avatar" do
  scenario "user uploads an avatar photo on sign up page" do
    user = FactoryGirl.build(:user)
    visit root_path
    click_link "Sign Up"

    fill_in "Username", with: user.username
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    fill_in "Confirm Password", with: user.password
    attach_file "Profile Photo", "#{Rails.root}/spec/support/images/skillet.png"

    click_button "Sign up"

    expect(page).to have_content("signed up successfully")
    expect(page).to have_css("img[src*='skillet.png']")

    logout(:user)
  end

  scenario "user uploads an avatar photo on update account page" do
    user = FactoryGirl.create(:user)
    login_as(user, scope: :user)

    visit root_path
    click_link "Edit profile"

    fill_in "Current Password", with: user.password
    attach_file "Profile Photo", "#{Rails.root}/spec/support/images/skillet.png"

    click_button "Update"

    expect(page).to have_content("Your account has been updated successfully.")
    expect(page).to have_css("img[src*='skillet.png']")

    logout(:user)
  end
end
