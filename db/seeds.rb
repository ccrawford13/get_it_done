require 'faker'

#Create Users
5.times do
  user = User.new(
    first_name:              Faker::Name.first_name,
    last_name:               Faker::Name.last_name,
    email:                   Faker::Internet.email,
    password:                'password',
    password_confirmation:   'password'
  )
  user.skip_confirmation!
  user.save!
end

admin = User.new(
  first_name:                'admin',
  last_name:                 'istrator',
  email:                     'chad@example.com',
  password:                  'password',
  password_confirmation:     'password'
  )
admin.skip_confirmation!
admin.save!

users = User.all

50.times do
  list = TodoList.create!(
    title:         Faker::Lorem.sentence,
    user:          users.sample
  )
end

lists = TodoList.all

100.times do
  new_item = Item.create!(
    title:        Faker::Lorem.sentence,
    todo_list:    lists.sample
  )
end

100.times do
  old_item = Item.create!(
    title:        Faker::Lorem.sentence,
    todo_list:    lists.sample
  )
  old_item.update_attributes(created_at: (Time.now - 4.days))
end

100.times do
  outdated_item = Item.create!(
    title:        Faker::Lorem.sentence,
    todo_list:    lists.sample
  )
  outdated_item.update_attributes(created_at: (Time.now - 7.days))
end

items = Item.all

puts "Seeds Finished"
puts "#{User.count} users created"
puts "#{TodoList.count} lists created"
puts "#{Item.count} items created"