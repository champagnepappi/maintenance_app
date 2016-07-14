# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
User.create!(name: "Anonymous Guy",
            email: "anonymous@gmail.com",
            password: "password",
            password_confirmation: "password",
            admin: true,
            activated: true,
            activated_at : Time.zone.now)

79.times do |n|
  name = Faker::Name.name
  email = "anonymous-#{n+1}@gmail.com"
  password="password"
  User.create!(name: name,
              email: email,
              password: password,
              password_confirmation: password,
              activated: true,
              activated_at: Time.zone.now)
end
