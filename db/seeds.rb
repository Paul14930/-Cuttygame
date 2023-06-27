# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
require "open-uri"

# ...
count = 1
puts "debut seed"
20.times do
  file = URI.open("https://picsum.photos/200/300?random=1")
puts "element en seed"
  profil = Profile.new(
    username: Faker::Internet.username,
    date_birth: Faker::Date.birthday(min_age: 18, max_age: 65),
    gender: Faker::Gender.binary_type,
    location: Faker::Address.city,
    orientation: Faker::Gender.type,
    description: Faker::Lorem.paragraphs.join("\n\n"),
    user_id: count,
    score: Faker::Number.between(from: 0, to: 10).to_f
  )
  profil.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
  profil.save

  User.create(email: "user#{count}@example.com", password: "password#{count}")

  count += 1

end
puts "seed fini"
