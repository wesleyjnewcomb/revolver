require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many :albums }

  it { should have_valid(:username).when('FewerThanTwenty') }
  it { should have_valid(:username).when('FewerThan20') }
  it { should have_valid(:username).when('under-20') }
  it { should have_valid(:username).when('under_20') }

  it { should_not have_valid(:username).when('!@#$%^&yo') }
  it { should_not have_valid(:username).when('SooooooooooooooooooooooManyLetters') }
  it { should_not have_valid(:username).when('a') }
  it { should_not have_valid(:username).when(nil, '') }

  it { should have_valid(:role).when(User.roles[:user])}
  it { should have_valid(:role).when(User.roles[:admin])}

  describe "#admin?" do

    it "should return true if the user is an admin" do
      admin = FactoryGirl.create(:user, role: User.roles[:admin])
      expect(admin.admin?).to eq true
    end

    it "should return false when the user is not an admin" do
      user = FactoryGirl.create(:user, role: User.roles[:user])
      expect(user.admin?).to eq false

    end
  end
end
