# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
prof = Professor.create!(
  name: "Dr. #{Faker::Name.name}",
  email: "p1@test.com",
  password: "password",
  password_confirmation: "password"
)

1.upto(10) do |i|
  Student.create!(
  name: "#{Faker::Name.name}",
  email: "s#{i}@test.com",
  password: "password",
  password_confirmation: "password"
  )

  Project.create!(
  title: "#{Faker::Hacker.verb} the #{Faker::Hacker.adjective} #{Faker::Hacker.noun}".titleize,
  professor: prof,
  description: Faker::Hacker.say_something_smart,
  publish_at: Time.now.utc
  )
end
