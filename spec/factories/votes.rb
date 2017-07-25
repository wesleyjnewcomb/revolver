FactoryGirl.define do
  factory :vote do
    value { rand(-1..1) }
    user { FactoryGirl.create(:user) }
    review { FactoryGirl.create(:review) }
  end
end
