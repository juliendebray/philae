# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'json'
require 'rest_client'
url_json = 'https://spreadsheets.google.com/feeds/list/1-Ftz7aXpUmfJCy6mp3eFD7N-XrWOPlSSEijxLifdq90/od6/public/values?alt=json'
data_hash = JSON.parse(RestClient.get(url_json))
data_hash['feed']['entry'].each do |exp_data|
  exp = Experience.create(
    average_rating: exp_data['gsx$rating']['$t'].to_f,
    name: exp_data['gsx$nomfrench']['$t'],
    address: exp_data['gsx$lieufrench']['$t'],
    latitude: exp_data['gsx$coord']['$t'].split(", ")[0].to_f,
    longitude: exp_data['gsx$coord']['$t'].split(", ")[1].to_f,
    description: exp_data['gsx$descriptionfrench']['$t'],
    published: true
  )
  gen_url = "http://philae-floju.s3.amazonaws.com/photos_thailande/"
  code = exp_data['gsx$code']['$t']
  (1..4).each do |i|
    complete_url = gen_url + code + "_#{i}.jpg"
    begin
      doc = open(complete_url)
    rescue OpenURI::HTTPError
      next
    end
    exp.experience_pictures.create(picture: complete_url)
  end
end




# Seed experiences

# #tableau_adresse
# #experience.create(address: adresse, name: , description: , user_id: 1, category_id: , image: url(../lattitude_longitude.jpg))

# Experience.create(
#   address: 'Merzouga, Morocco',
#   name: 'merzouga',
#   description: 'test',
#   user_id: 1,
#   category_id: rand(1..3),
#   )



# Experience.create(
#   address: 'marrakech, Morocco',
#   name: 'marra',
#   description: 'test',
#   user_id: 1,
#   category_id: rand(1..3)
#   )
# Experience.create(
#   address: 'fes, Morocco',
#   name: 'fes',
#   description: 'test',
#   user_id: 1,
#   category_id: rand(1..3)
#   )
# Experience.create(
#   address: 'casablanca, Morocco',
#   name: 'casa',
#   description: 'test',
#   user_id: 1,
#   category_id: rand(1..3)
#   )
# Experience.create(
#   address: 'rabat, Morocco',
#   name: 'rabat',
#   description: 'test',
#   user_id: 1,
#   category_id: rand(1..3)
#   )



# # Seed  experience_reviews

# Experience.all.each do |exp|
#   ExperienceReview.create(
#     user_id: 1,
#     experience_id: exp.id,
#     comment: 'test for experience with id #{exp.id}',
#     rating: rand(0..5)
#   )
# end

