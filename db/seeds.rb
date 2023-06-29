# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
require "open-uri"

puts "destruction profils"
Profile.destroy_all
puts "destruction users"
# Supprimer tous les enregistrements de la table 'users'
User.destroy_all

# ...
count = 1
puts "debut seed"
10.times do
  file = URI.open("https://picsum.photos/200/300?random=1")
puts "element en seed Homme"
user = User.create!(email: "user#{count}@example.com", password: "password#{count}")
  profil = Profile.new(
    username: Faker::Name.male_first_name,
    date_birth: Faker::Date.birthday(min_age: 18, max_age: 65),
    gender: "Homme",
    location: Faker::Address.city,
    orientation: "Homme",
    description: Faker::Lorem.paragraphs.join("\n\n"),
    user_id: user.id,
    score: Faker::Number.between(from: 2000, to: 2500).to_f,
    division: 1
  )
  profil.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
  profil.save


  count += 1

end
10.times do
  file = URI.open("https://picsum.photos/200/300?random=1")
puts "element en seed Femme"
user = User.create!(email: "user#{count}@example.com", password: "password#{count}")
  profil = Profile.new(
    username: Faker::Name.female_first_name,
    date_birth: Faker::Date.birthday(min_age: 18, max_age: 65),
    gender: "Femme",
    location: Faker::Address.city,
    orientation: "Femme",
    description: Faker::Lorem.paragraphs.join("\n\n"),
    user_id: user.id,
    score: Faker::Number.between(from: 2000, to: 2500).to_f,
    division: 1
  )
  profil.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
  profil.save


  count += 1

end
puts "seed fini"
