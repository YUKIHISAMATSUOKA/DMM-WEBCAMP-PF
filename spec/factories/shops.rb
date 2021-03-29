FactoryBot.define do
  factory :shop do
    name { Faker::Lorem.characters(number: 10) }
    introduction { Faker::Lorem.characters(number: 20) }
    post_code { Faker::Number.number(digits: 7) }
    address { Faker::Address.street_address }
    telephone_number { Faker::Number.number(digits: 9) }
    area
    customer
  end
end
