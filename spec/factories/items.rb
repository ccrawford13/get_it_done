require 'faker'

FactoryGirl.define do
  factory :item do
    title {Faker::Lorem.sentence}
    todo_list
  end
end
