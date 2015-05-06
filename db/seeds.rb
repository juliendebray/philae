# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#Mise en ligne des avis du Routard
require 'json'
require 'rest_client'
url_json = 'https://spreadsheets.google.com/feeds/list/1lT3aqMKPqTbSZAhP0BS3yU-_TN595sRyuBRt2A3riQI/od6/public/values?alt=json'
data_hash = JSON.parse(RestClient.get(url_json))
data_hash['feed']['entry'].each do |leader_review|
  leader_review = LeaderReview.create(
    experience_id: leader_review['gsx$experienceid']['$t'].to_f,
    source: leader_review['gsx$source']['$t'],
    comment: leader_review['gsx$comment']['$t'],
  )
end


#Implémentation must-see et Liste des 1000 lieux à voir dans sa vie
# require 'json'
# require 'rest_client'
# url_json = 'https://spreadsheets.google.com/feeds/list/1yqaP4CpQUrI1gJGUuYmPqtIFGcclVM0BIX_T2xVrORQ/od6/public/values?alt=json'
# data_hash = JSON.parse(RestClient.get(url_json))
# data_hash['feed']['entry'].each do |exp_data|
#   Experience.find(exp_data['gsx$experienceid']['$t'].to_i).update(
#     must_see: exp_data['gsx$mustsee']['$t'],
#     unesco: exp_data['gsx$unesco']['$t']
#   )
# end


#Mise à jour du lien Wikipedia
# require 'json'
# require 'rest_client'
# url_json = 'https://spreadsheets.google.com/feeds/list/1XnCFrrMTgnyBjkW5rcaaub5dP00zL1DZNmXdvDo3szw/od6/public/values?alt=json'
# data_hash = JSON.parse(RestClient.get(url_json))
# data_hash['feed']['entry'].each do |exp_data|
#   Experience.find(exp_data['gsx$experienceid']['$t'].to_i).update(wikipedia_link: exp_data['gsx$wikipedialink']['$t'] )
# end

# Mise à jour du nb de votes par experiences
# require 'json'
# require 'rest_client'
# url_json = 'https://spreadsheets.google.com/feeds/list/19aquHyh7DOdJppZ4-NbT9h1oeTX0pGRZfEHZwym6BiM/od6/public/values?alt=json'
# data_hash = JSON.parse(RestClient.get(url_json))
# data_hash['feed']['entry'].each do |exp_data|
#   Experience.find(exp_data['gsx$experienceid']['$t'].to_i).update(nb_votes: exp_data['gsx$nbvotes']['$t'].to_i )
# end




# Ajout des experiences_reviews
# require 'json'
# require 'rest_client'
# url_json = 'https://spreadsheets.google.com/feeds/list/1SKEiOrcHDZJHdE12JU7NSSYDmkJRsEvUjXWxMP0O1R0/od6/public/values?alt=json'
# data_hash = JSON.parse(RestClient.get(url_json))
# data_hash['feed']['entry'].each do |experience_review|
#   exp_review = ExperienceReview.create(
#     experience_id: experience_review['gsx$experienceid']['$t'].to_f,
#     name: experience_review['gsx$name']['$t'],
#     rating: experience_review['gsx$rating']['$t'].to_f * 2,
#     original_date: experience_review['gsx$originaldate']['$t'],
#     comment: experience_review['gsx$comment']['$t']
#   )
# end


# Ajout des leaders reviews (citations guides)
# require 'json'
# require 'rest_client'
# url_json = 'https://spreadsheets.google.com/feeds/list/1oIYSGswUzoImlGBWuVyFmw2k9y-8DSUxzC_38m3CTIs/od6/public/values?alt=json'
# data_hash = JSON.parse(RestClient.get(url_json))
# data_hash['feed']['entry'].each do |leader_review|
#   leader_review = LeaderReview.create(
#     experience_id: leader_review['gsx$experienceid']['$t'].to_f,
#     source: leader_review['gsx$source']['$t'],
#     comment: leader_review['gsx$comment']['$t'],
#   )
# end




# Seed Destination

# require 'json'
# require 'rest_client'
# url_json = 'https://spreadsheets.google.com/feeds/list/1f5WSB7ew6aCspE1IysJ3RYZiCqeOjJBYZ-UYzzEBR18/od6/public/values?alt=json'
# data_hash = JSON.parse(RestClient.get(url_json))
# data_hash['feed']['entry'].each do |destination_data|
#   destination = Destination.create(
#     name: destination_data['gsx$name']['$t'],
#     ne_lat: destination_data['gsx$nelat']['$t'].to_f,
#     ne_lng: destination_data['gsx$nelng']['$t'].to_f,
#     sw_lat: destination_data['gsx$swlat']['$t'].to_f,
#     sw_lng: destination_data['gsx$swlng']['$t'].to_f,
#     overview: destination_data['gsx$overview']['$t'],
#     formalities: destination_data['gsx$formalities']['$t'],
#     regions: destination_data['gsx$regions']['$t'],
#     transportation: destination_data['gsx$transportation']['$t'],
#   )
# end


# Seed experiences

# require 'json'
# require 'rest_client'
# url_json = 'https://spreadsheets.google.com/feeds/list/19aquHyh7DOdJppZ4-NbT9h1oeTX0pGRZfEHZwym6BiM/od6/public/values?alt=json'
# data_hash = JSON.parse(RestClient.get(url_json))
# data_hash['feed']['entry'].each do |exp_data|
#   exp = Experience.create(
#     average_rating: exp_data['gsx$rating']['$t'].to_f,
#     name: exp_data['gsx$nomfrench']['$t'],
#     address: exp_data['gsx$lieufrench']['$t'],
#     latitude: exp_data['gsx$coord']['$t'].split(", ")[0].to_f,
#     longitude: exp_data['gsx$coord']['$t'].split(", ")[1].to_f,
#     description: exp_data['gsx$descriptionfrench']['$t'],
#     published: true
#   )
#   gen_url = "http://philae-floju.s3.amazonaws.com/photos_liban/"
#   code = exp_data['gsx$code']['$t']
#   (1..4).each do |i|
#     complete_url = gen_url + code + "_#{i}.jpg"
#     begin
#       doc = open(complete_url)
#     rescue OpenURI::HTTPError
#       next
#     end
#     exp.experience_pictures.create(picture: complete_url)
#   end
# end


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

