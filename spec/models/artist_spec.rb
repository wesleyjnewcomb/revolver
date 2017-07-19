require 'rails_helper'

RSpec.describe Artist, type: :model do
  it { should have_many(:albums) }

  it { should have_valid(:name).when('The Beatles') }
  it { should_not have_valid(:name).when(nil, '') }

  it { should validate_uniqueness_of(:name) }
end
