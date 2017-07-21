require 'rails_helper'

RSpec.describe Review, type: :model do
  it { should belong_to(:album) }
  it { should belong_to(:user) }

  it { should have_valid(:rating).when(7) }
  it { should_not have_valid(:rating).when(0) }
  it { should_not have_valid(:rating).when(11) }
  it { should_not have_valid(:rating).when(nil) }
end
