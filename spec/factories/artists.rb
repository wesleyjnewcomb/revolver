require 'faker'

FactoryGirl.define do
  factory :artist do
    name Faker::Name.unique.name
  end
end
