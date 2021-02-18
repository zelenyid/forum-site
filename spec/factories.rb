require 'faker'

FactoryBot.define do
  factory :user do
    name { 'John' }
    email  { Faker::Internet.email }
    password { '123456' }
    password_confirmation { '123456' }
    user_role { false }
    moderator { false }
    admin { false }
  end

  factory :topic do
    title { Faker::Food.fruits }
    description { Faker::Food.description }
  end
end
