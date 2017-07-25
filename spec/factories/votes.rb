FactoryGirl.define do
  factory :vote do
    user { FactoryGirl.create(:user) }
    review { FactoryGirl.create(:review) }

    value { rand(-1..1) }
  end
end
