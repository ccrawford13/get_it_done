require 'faker'

FactoryGirl.define do
  factory :todo_list do
    title {Faker::Lorem.sentence}
    user
  end
end
