FactoryGirl.define do
  factory :album do
    uploader { FactoryGirl.create(:user) }
    title "Junta"
    artist { FactoryGirl.create(:artist) }
  end
end
