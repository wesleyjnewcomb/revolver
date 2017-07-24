require 'rails_helper'

feature 'user edits profile' do
  let!(:user) { FactoryGirl.create(:user) }
  before(:each) { login_as(user, scope: :user) }
  after(:each) { logout(:user) }

  scenario 'user goes to edit profile page' do
    visit '/'
    click_on 'Edit profile'
    expect(page).to have_content('Edit User')
  end

  scenario 'form has correct fields' do
    visit edit_user_registration_path

    expect(page).to have_content 'Username'
    expect(page).to have_content 'Email'
    expect(page).to have_content 'Password'
    expect(page).to have_content 'Confirm Password'
    expect(page).to have_content 'Current Password'
    expect(page).to have_button('Update')
  end

  scenario 'user fills out form with valid values and submits' do
    visit edit_user_registration_path
    id = user.id
    fill_in 'Username', with: 'rustyshackleford'
    fill_in 'Email', with: 'dale@gribble.com'
    fill_in 'Password', with: 'testtest'
    fill_in 'Confirm Password', with: 'testtest'
    fill_in 'Current Password', with: user.password

    click_on 'Update'

    user = User.find(id)
    expect(page).to have_content 'Your account has been updated successfully.'
    expect(user.username).to eq 'rustyshackleford'
    expect(user.email).to eq 'dale@gribble.com'
  end

  scenario 'user fills out form with invalid values' do
    visit edit_user_registration_path
    id = user.id
    fill_in 'Username', with: 'a'
    fill_in 'Email', with: 'dalegribble.com'
    fill_in 'Password', with: 'testtest'
    fill_in 'Confirm Password', with: 'testtest'
    fill_in 'Current Password', with: user.password

    click_on 'Update'

    expect(page).to have_content 'errors prohibited this user from being saved'
  end

  scenario 'user does not fill out current password' do
    visit edit_user_registration_path
    id = user.id
    fill_in 'Username', with: 'rustyshackleford'
    fill_in 'Email', with: 'dale@gribble.com'
    fill_in 'Password', with: 'testtest'
    fill_in 'Confirm Password', with: 'testtest'

    click_on 'Update'

    expect(page).to have_content 'Current password can\'t be blank'
  end
end
