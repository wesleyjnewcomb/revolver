require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:review) }

  it { should have_valid(:value).when(1,0,-1) }
  it { should_not have_valid(:value).when(2,-2,0.5) }
end
