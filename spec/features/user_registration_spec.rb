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

    # fill_in 'Username', with: 'TestUser'
    fill_in 'Email', with: 'TestUser@launch.com'
    fill_in 'Password', with: 'TestUserPassword'

    click_button 'Sign up'

    expect(page).to have_content('Account created')
  end

  scenario 'user does not fill all fields and submit fails' do
    visit '/'
    click_on 'Sign Up'

    # fill_in 'Username', with: 'TestUser'
    fill_in 'Password', with: 'TestUserPassword'

    click_button 'Sign up'

    expect(page).to have_content('Failed to create account')
  end
end
