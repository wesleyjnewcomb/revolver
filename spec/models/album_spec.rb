require 'rails_helper'

RSpec.describe Album, type: :model do
  it { should belong_to(:uploader) }
  it { should belong_to(:artist) }

  it { should have_valid(:title).when('Revolver') }
  it { should have_valid(:title).when('( )') }

  it { should_not have_valid(:title).when(nil, '') }

  it { should have_valid(:year_released).when(1965) }
  it { should have_valid(:year_released).when(3000) }
  it { should have_valid(:year_released).when(nil) }
  it { should_not have_valid(:year_released).when(1899) }

  it { should have_valid(:month_released).when(0) }
  it { should have_valid(:month_released).when(11) }
  it { should have_valid(:month_released).when(nil) }
  it { should_not have_valid(:month_released).when(12) }
  it { should_not have_valid(:month_released).when(-1) }
end
