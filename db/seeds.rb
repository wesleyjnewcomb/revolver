# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
phish = Artist.create(name: "Phish")
beatles = Artist.create(name: "The Beatles")
zappa = Artist.create(name: "Frank Zappa")
pearljam = Artist.create(name: "Perl Jam")

eben = User.create(email: "eben@lowe.com", username: "enthusiastick", password: "itseben")

Album.create({
  uploader: eben,
  title: "Ten",
  artist: pearljam,
  date_released: Date.new(1991, 8, 27)
})
junta = Album.create({
  uploader: eben,
  title: "Junta",
  artist: phish,
  date_released: Date.new(1989, 5, 8)
})
Album.create({
  uploader: eben,
  title: "Lawn Boy",
  artist: phish,
  date_released: Date.new(1995, 4, 3)
})
help = Album.create({
  uploader: eben,
  title: "Help",
  artist: beatles,
  date_released: Date.new(1965, 8, 6)
})
Album.create({
  uploader: eben,
  title: "Rubber Soul",
  artist: beatles,
  date_released: Date.new(1965, 12, 6)
})
Album.create({
  uploader: eben,
  title: "Revolver",
  artist: beatles,
  date_released: Date.new(1966, 8, 5)
})
Album.create({
  uploader: eben,
  title: "Sgt. Pepper's Lonely Hearts Club Band",
  artist: beatles,
  date_released: Date.new(1967, 5, 26)
})
Album.create({
  uploader: eben,
  title: "Apostrophe",
  artist: zappa,
  date_released: Date.new(1974, 3, 22)
})

Review.create({
  album: help,
  user: eben,
  body: 'album suxxx',
  rating: 2
})
Review.create({
  album_id: 1,
  user_id: 1,
  body: 'dis album aight',
  rating: 2
})
