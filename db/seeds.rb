require 'faker'
puts "Destruction profils"
Profile.destroy_all
puts "Destruction users"
User.destroy_all
 count = 1
  puts "Début seed"

  80.times do
    puts "Element en seed Homme"
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
      division: rand(1..6)
    )

    file = File.open(Rails.root.join('seed_images', "H#{count}.jpg"))
    profil.photo.attach(io: file, filename: "H#{count}.jpg", content_type: 'image/jpeg')
    profil.save

    count += 1
  end
  puts "seed finis"

  count = 1

  40.times do
    puts "Element en seed Femme"
    user = User.create!(email: "user#{count + 100}@example.com", password: "password#{count}")

      profil = Profile.new(
      username: Faker::Name.female_first_name,
      date_birth: Faker::Date.birthday(min_age: 18, max_age: 65),
      gender: "Femme",
      location: Faker::Address.city,
      orientation: "Femme",
      description: Faker::Lorem.paragraphs.join("\n\n"),
      user_id: user.id,
      score: Faker::Number.between(from: 2000, to: 2500).to_f,
      division: rand(1..6)
    )
     file = File.open(Rails.root.join('seed_images', "F#{count}.jpg"))
     profil.photo.attach(io: file, filename: "F#{count}.jpg", content_type: 'image/jpeg')
     profil.save

    count += 1
  end
  puts "seed finis"
