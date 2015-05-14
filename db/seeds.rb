require 'faker'

#Create Users
5.times do
  user = User.new(
    first_name:          Faker::Name.first_name,
    last_name:           Faker::Name.last_name,
    email:               Faker::Internet.email,
    password:            Faker::Lorem.characters(8)
  )
  user.skip_confirmation!
  user.save!
end

admin = User.new(
  first_name:           'admin',
  last_name:            'istrator',
  email:                'chad@example.com',
  password:             'password'
  )
admin.skip_confirmation!
admin.save!

users = User.all

200.times do
  list = TodoList.create!(
    title:         Faker::Lorem.sentence,
    user:          users.sample
  )
end

lists = TodoList.all

100.times do
  item = Item.create!(
    title:        Faker::Lorem.sentence,
    todo_list:    lists.sample
  )
end

items = Item.all

puts "Seeds Finished"
puts "#{User.count} users created"
puts "#{TodoList.count} lists created"
puts "#{Item.count} items created"