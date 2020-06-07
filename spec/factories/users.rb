FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    state { "active" }
    role { "doctor" }
    date_of_birth { Time.zone.now.to_date }
  end
end