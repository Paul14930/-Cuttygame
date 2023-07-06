require 'faker'
puts "Destruction profils"
# Chatroom.destroy_all
Profile.destroy_all
puts "Destruction users"
User.destroy_all
prenom_homme = [
  "Damien", "Christoph", "Olivier", "William", "Jonathan", "Greg", "Virgil", "Christof", "Anan-Jules",
  "Baptiste", "Paul", "PAUL2", "Mazen", "Bastien", "Mathieu", "Kevin", "Jean-Francois", "Léo", "Loic",
  "OLIVIER2", "Raphael", "Zied", "Ludovic", "LUDOVIC2", "Thomas", "Adam", "Vincent", "Abdiel", "Adrien",
  "Marc", "David", "Ryan", "Guillaume", "GUILLAUME2", "Julien", "JULIEN2", "Dimitri", "Jean1-Paul3",
  "Xavier", "Andrea", "Sebastien", "Cédric", "Fabrice", "JULIEN3", "Yohan", "Harouna-Madou", "Nordin",
  "Manuel", "GUILLAUME3", "Jonathan2", "Jerome", "Gabriel", "David2", "Adil", "Sebastien2", "Charly",
  "Djampa", "Teddy", "Louis-Arthur", "Axel", "Mathieu2", "Evan", "Mike", "Rudy", "Damien2", "Tom",
  "Romain", "Alexy", "Louis", "Axel2", "Naceur", "Mickael", "Ingo", "Alexandru", "Sliman", "Mathieu3",
  "Pierre-Ange", "Basile", "Hadrien", "Tanguy", "Jamal"
]
prenom_femme = [
  "Marion", "Veronika", "Elena", "Kahina", "Barbara", "Violette", "Camille", "Valeria", "Lou-Salome",
  "Lila", "Nino", "Karyna", "Marilou", "Morgane", "Alexia", "Alice", "Melanie", "Sophie", "MARION2",
  "Diana", "Angela", "Sabah", "Celine", "Martina", "Elisa", "Thi-Thang", "SILVIA", "Alexandra",
  "Kelly", "Silvia2", "Cleo", "Anna", "Ekaterina", "Emmanuelle", "Stephanie", "Katja", "Yasmine",
  "Anne-Sophie", "Valentine", "Pauline", "Clarisse", "Audrey"
]
description_femme = [
  "Fervente amatrice de chocolat noir, je peux passer des heures à débattre sur la supériorité du 70% cacao. Je suis également une passionnée de salsa et j'adore les randonnées en montagne.",
  "Je suis une véritable aventurière, une grande fan de cuisine asiatique et je peux parler quatre langues. Si tu es prêt pour une aventure culinaire, je suis celle qu'il te faut.",
  "Je suis une passionnée de yoga, une amatrice de vin rouge et je suis capable de citer tous les dialogues de 'Pride and Prejudice'. Si tu cherches quelqu'un qui adore les dimanches paresseux, nous pourrions bien nous entendre.",
  "Je suis une fan de séries Netflix, une grande amatrice de concerts et je peux jouer du ukulélé. Si tu aimes la musique et les séries, je suis celle qu'il te faut.",
  "Je suis une amoureuse des animaux, une grande fan de sport et j'ai un talent caché pour la danse. Si tu cherches quelqu'un avec qui courir le matin, ne cherche pas plus loin.",
  "Je suis une amatrice d'art, une grande fan de cuisine méditerranéenne et je peux faire du stand-up. Si tu cherches une vie pleine de rires, je suis celle qu'il te faut.",
  "Je suis une amoureuse de la nature, une grande fan de comédies musicales et j'ai une collection impressionnante de vinyles. Si tu cherches quelqu'un pour partager des moments inoubliables, je pourrais être ta femme.",
  "Je suis une amatrice de poésie, une passionnée de mode et je peux résoudre un Rubik's Cube en moins de deux minutes. Si tu cherches une femme qui peut te surprendre, je suis là.",
  "Je suis une amatrice de thé, une grande fan de lecture et j'ai un talent caché pour le chant. Si tu cherches une vie pleine de douceur et de mélodies, je suis celle qu'il te faut.",
  "Je suis une passionnée de voyages, une grande fan de sports nautiques et j'ai une passion pour la photographie. Si tu cherches quelqu'un qui aime l'aventure, je suis celle qu'il te faut."
]
description_homme = [
  "Amateur de fromages rares, je peux passer des heures à discuter de la texture du camembert. En dehors de ça, je suis un super-héros à mes heures perdues et j'apprécie une bonne tasse de thé à minuit.",
  "Je suis un passionné de romans de science-fiction, un adepte de la sieste et je peux préparer des pâtes comme personne. Mon but dans la vie ? Trouver le meilleur tiramisu au monde.",
  "Je suis un voyageur dans l'âme, un grand fan de karaoké et j'ai un don pour parler aux animaux. Si tu cherches quelqu'un avec qui chanter sous la pluie, tu as frappé à la bonne porte.",
  "Je suis un maître du jeu de société, un adepte des promenades à la plage au clair de lune et un cordon bleu en herbe. Je promets de ne jamais utiliser de « pick-up lines » ringardes.",
  "Je suis un amoureux des livres, un marathonien à mes heures perdues et je prépare les meilleurs pancakes de la ville. Si tu aimes rire, alors nous devrions bien nous entendre.",
  "Je suis un fanatique de films d'horreur, un joueur de guitare amateur et je peux réciter tous les épisodes de 'Friends'. Si tu es à la recherche d'aventures et de rires, je suis ton homme.",
  "Je suis un as de la blague, un mordu de cuisine italienne et j'ai une collection impressionnante de chaussettes à motifs. Si tu cherches une vie pleine de surprises, ne cherche pas plus loin.",
  "Je suis un amoureux des étoiles, un danseur de salsa enthousiaste et je peux faire le moonwalk. Si tu cherches quelqu'un qui n'a pas peur d'être ridicule, tu as trouvé ton match.",
  "Je suis un passionné de musique classique, un amateur de yoga et je peux faire un Rubik's Cube en moins de deux minutes. Si tu cherches quelqu'un qui peut te défier, je suis là.",
  "Je suis un amoureux de la nature, un fan de comédies musicales et j'ai un talent caché pour le dessin. Si tu cherches quelqu'un pour partager des moments inoubliables, je pourrais être ton homme."
]
  count = 1
  puts "Début seed"
  80.times do
    puts "Element en seed Homme"
    user = User.create!(email: "#{prenom_homme[count-1]}@cuty.com", password: "123456")
    profil = Profile.new(
      username: prenom_homme[count-1],
      date_birth: Faker::Date.birthday(min_age: 18, max_age: 65),
      gender: "Homme",
      location: Faker::Address.city,
      orientation: "Homme",
      description: description_homme.sample,
      user_id: user.id,
      score: Faker::Number.between(from: 2000, to: 3000).to_f,
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
    user = User.create!(email: "#{prenom_femme[count-1]}@cuty.com", password: "123456")
      profil = Profile.new(
        username: prenom_femme[count-1],
      date_birth: Faker::Date.birthday(min_age: 18, max_age: 65),
      gender: "Femme",
      location: Faker::Address.city,
      orientation: "Femme",
      description: description_femme.sample,
      user_id: user.id,
      score: Faker::Number.between(from: 2000, to: 3000).to_f,
      division: rand(1..6)
    )
     file = File.open(Rails.root.join('seed_images', "F#{count}.jpg"))
     profil.photo.attach(io: file, filename: "F#{count}.jpg", content_type: 'image/jpeg')
     profil.save
    count += 1
  end
  puts "seed finis"
