require 'faker'

FactoryGirl.define do
  factory :item do
    title {Faker::Lorem.sentence}
    completed false
    todo_list
  end
end
