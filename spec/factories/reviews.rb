require 'faker'

FactoryGirl.define do
  factory :review do
    rating { rand(1..10) }
    body { Faker::Hipster.paragraph }
    album { FactoryGirl.create(:album) }
    user { FactoryGirl.create(:user) }
  end
end
