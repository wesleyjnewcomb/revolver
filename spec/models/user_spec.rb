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
end
