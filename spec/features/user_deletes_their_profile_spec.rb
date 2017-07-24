require 'rails_helper'

feature 'user edits profile' do
  let!(:user) { FactoryGirl.create(:user) }
  before(:each) { login_as(user, scope: :user) }
  after(:each) { logout(:user) }

  scenario 'user sees delete account button on edit profile page' do
    visit edit_user_registration_path
    expect(page).to have_button('Delete my account')
  end

  scenario 'user successfully deletes account' do
    id = user.id
    visit edit_user_registration_path
    click_on('Delete my account')

    expect(User.exists?(id)).to eq false
  end
end
