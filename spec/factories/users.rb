FactoryGirl.define do
  factory :user do
    username "hankhill"
    email { "bob@example.com" }
    password "password"
  end
end
