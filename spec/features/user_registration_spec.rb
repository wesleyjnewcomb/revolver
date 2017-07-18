require 'rails_helper'

feature 'User registration' do
  scenario 'user visits sign up page' do
    visit '/'
    click_on 'Sign Up'

    expect(page).to have_content('Create an account')
  end

  scenario 'user fills all fields and submits' do
    visit '/'
    click_on 'Sign Up'

    fill_in 'Username', with: 'TestUser'
    fill_in 'Email', with: 'TestUser@launch.com'
    fill_in 'Password', with: 'TestUserPassword'
    fill_in 'Confirm Password', with: 'TestUserPassword'

    click_button 'Sign up'

    expect(page).to have_content('signed up successfully')
  end

  scenario 'user does not fill all fields and submit fails' do
    visit '/'
    click_on 'Sign Up'

    fill_in 'Username', with: 'TestUser'
    fill_in 'Password', with: 'TestUserPassword'

    click_button 'Sign up'

    expect(page).to have_content('prohibited this user from being saved')
  end

  scenario 'user enters invalid email' do
    visit new_user_registration_path

    fill_in 'Email', with: 'Invalid_email'
    fill_in 'Password', with: 'TestUserPassword'
    fill_in 'Confirm Password', with: 'TestUserPassword'

    click_button 'Sign up'

    expect(page).to have_content('Email is invalid')
  end

end
