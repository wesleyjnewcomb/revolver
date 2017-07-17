require 'rails_helper'


describe User do
  it { should have_valid(:username).when("Liz") }
  it { should_not have_valid(:username).when(nil, "") }

  it { should have_valid(:username).when("Lemon") }
  it { should_not have_valid(:username).when(nil, "") }
  it { should_not have_valid(:username).when("This is more than twenty characters") }

  it { should have_valid(:email).when("yo@hey.com") }
  it { should have_valid(:email).when("yo@hey.com") }
  it { should_not have_valid(:email).when(nil, "") }

end
