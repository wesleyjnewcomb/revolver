require 'rails_helper'

feature 'user logs in' do
  let(:bobby) { FactoryGirl.create(:user) }
  scenario 'user enters valid login credentials' do

    visit new_user_session_path

    fill_in 'Email', with: bobby.email
    fill_in 'Password', with: bobby.password

    click_button 'login-button'

    expect(page).to have_content('Signed in successfully')
  end

  scenario 'user enters valid login credentials and sees username in nav-bar' do

    visit new_user_session_path

    fill_in 'Email', with: bobby.email
    fill_in 'Password', with: bobby.password

    click_button 'login-button'

    expect(page).to have_content(bobby.username)
  end

  scenario 'user enters valid login credentials' do
    visit '/'

    click_on 'Log in'

    fill_in 'Email', with: bobby.email
    fill_in 'Password', with: bobby.password + 'a'

    click_button 'login-button'

    expect(page).to have_content('Invalid Email or password')
  end
end
