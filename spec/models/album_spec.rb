require 'rails_helper'

RSpec.describe Album, type: :model do
  it { should belong_to(:uploader) }

  it { should have_valid(:title).when('Revolver') }
  it { should have_valid(:title).when('( )') }

  it { should_not have_valid(:title).when(nil, '') }

  it { should have_valid(:date_released).when(Date.today) }
  it { should have_valid(:date_released).when(nil) }
end
