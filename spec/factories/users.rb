require 'faker'

FactoryGirl.define do
  factory :user do
    username "hankhill"
    email { Faker::Internet.unique.email }
    password "password"
  end
end
