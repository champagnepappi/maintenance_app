# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
User.create!(name: "That Dude",
            email: "kevinochieng548@gmail.com",
            contact: "0705263536",
            password: "password",
            password_confirmation: "password",
            role: 1,
            activated: true,
            activated_at: Time.zone.now)

79.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.email
  contact = Faker::Number.number(10)
  password="password"
  User.create!(name: name,
              email: email,
              password: password,
              contact: contact,
              password_confirmation: password,
              activated: true,
              activated_at: Time.zone.now)
end

users = User.order(:created_at).take(5)
5.times do
  content = Faker::Lorem.sentence(5)
  users.each {|user| user.requests.create!(content: content)}
end
