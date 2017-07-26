# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
beatles = Artist.create(name: "The Beatles")
led_zeppelin = Artist.create(name: 'Led Zeppelin')

wesley = User.create(email: "wesleyjnewcomb@gmail.com", username: "wnewcomb", password: "testtest")
nick = User.create(email: 'n.mikita3@gmail.com', username: 'nm357', password: 'testtest')


revolver = Album.create({
  uploader: wesley,
  title: "Revolver",
  artist: beatles,
  year_released: 1966,
  month_released: 7
})

peppers = Album.create({
  uploader: wesley,
  title: "Sgt. Pepper's Lonely Hearts Club Band",
  artist: beatles,
  year_released: 1967,
  month_released: 4
})

zepp3 = Album.create({
  uploader: wesley,
  title: "Led Zeppelin III",
  artist: led_zeppelin,
  year_released: 1970,
  month_released: 9
})

Review.create({
  album: revolver,
  user: wesley,
  body: 'The Beatles\' very best!',
  rating: 9
})

Review.create({
  album: peppers,
  user: wesley,
  body: 'Never understood all the excitement around this. Definitely solid though',
  rating: 7
})

pepper = Review.create({
  album: peppers,
  user: nick,
  body: 'Overtly psychedelic; an important pop landmark. Good songwriting. Special favorite: Lovely Rita.',
  rating: 8
})

Review.create({
  album: zepp3,
  user: wesley,
  body: 'III > IV',
  rating: 10
})

vote1 = Vote.create(user: nick, review: pepper, value: 1)
vote2 = Vote.create(user: wesley, review: pepper, value: 1)
