require 'faker'

FactoryGirl.define do
  factory :album do
    uploader { FactoryGirl.create(:user) }
    title { Faker::Hipster.word.capitalize }
    year_released { rand(1960..2030) }
    month_released { rand(0..11) }
    artist { FactoryGirl.create(:artist) }
  end
end
