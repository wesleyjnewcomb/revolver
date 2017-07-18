FactoryGirl.define do
  factory :user do
    username "John"
    email { "#{name}@example.com" }
    last_signed_in { 10.days.ago }
    password "password"
  end
end
