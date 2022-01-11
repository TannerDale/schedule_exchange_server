FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { 'hello_world' }
    password_confirmation { 'hello_world' }
    role { [0, 1, 2].sample }

    association :company
  end
end
