FactoryBot.define do
  factory :company do
    name { Faker::Lorem.word }
    password { 'company' }
    password_confirmation { 'company' }
  end
end
