# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Seed experiences

#tableau_adresse
#experience.create(address: adresse, name: , description: , user_id: 1, category_id: , image: url(../lattitude_longitude.jpg))

Experience.create(
  address: 'Merzouga, Morocco',
  name: 'merzouga',
  description: 'test',
  user_id: 1,
  category_id: rand(1..3),
  )



Experience.create(
  address: 'marrakech, Morocco',
  name: 'marra',
  description: 'test',
  user_id: 1,
  category_id: rand(1..3)
  )
Experience.create(
  address: 'fes, Morocco',
  name: 'fes',
  description: 'test',
  user_id: 1,
  category_id: rand(1..3)
  )
Experience.create(
  address: 'casablanca, Morocco',
  name: 'casa',
  description: 'test',
  user_id: 1,
  category_id: rand(1..3)
  )
Experience.create(
  address: 'rabat, Morocco',
  name: 'rabat',
  description: 'test',
  user_id: 1,
  category_id: rand(1..3)
  )



# Seed  experience_reviews

Experience.all.each do |exp|
  ExperienceReview.create(
    user_id: 1,
    experience_id: exp.id,
    comment: 'test for experience with id #{exp.id}',
    rating: rand(0..5)
  )
end

