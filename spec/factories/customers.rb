# FactoryBot.define do
#   factory :customer do
#     last_name { Faker::Lorem.characters(number: 10) }
#     first_name { Faker::Lorem.characters(number: 10) }
#     kana_last_name { Faker::Lorem.characters(number: 10) }
#     kana_first_name { Faker::Lorem.characters(number: 10) }
#     email { Faker::Internet.email }
#     password { 'password' }
#     password_confirmation { 'password' }
#   end
# end

FactoryBot.define do
  factory :customer do
    last_name {"令和"}
    first_name {"はなこ"}
    kana_last_name {"レイワ"}
    kana_first_name {"ハナコ"}
    email { Faker::Internet.email }
    member_state {"true"}
    password { 'password' }
    password_confirmation { 'password' }
  end
end