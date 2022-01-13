FactoryBot.define do
  factory :store do
    street_address { Faker::Address.street_address }
    zip_code { Faker::Address.zip_code }
    store_number { Faker::Number.number(digits: 5) }

    association :company
  end
end
