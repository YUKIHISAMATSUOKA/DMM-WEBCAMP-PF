FactoryBot.define do
  factory :area do
    name { Faker::Lorem.characters(number: 10) }
  end
end
