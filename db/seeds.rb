# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Seed Cuba's experiences with trip advisor
# require 'json'
# require 'rest_client'
# # Update Cuba's experiences with ta id
# # url_json = "https://spreadsheets.google.com/feeds/list/1VNjWN-IZpIdh7tMNk8nUxzvsprkd2twDGVyJn0fGvxA/od6/public/values?alt=json"
# # data_hash = JSON.parse(RestClient.get(url_json))
# # data_hash['feed']['entry'].each do |exp_data|
# #   if exp_data['gsx$taid']['$t'] && exp_data['gsx$taid']['$t'].length > 0
# #     exp = Experience.find_by(onesentence: exp_data['gsx$onesentence']['$t'])
# #     exp.update(ta_id: exp_data['gsx$taid']['$t'])
# #   end
# # end
# # Update Cuba's experiences with ta ratings and comments
# url_json = "https://spreadsheets.google.com/feeds/list/1HnsPxssywuNPjNFTsZoHwfeefgN5huPr0QahdZwWHJE/od6/public/values?alt=json"
# data_hash = JSON.parse(RestClient.get(url_json))
# tab = []
# data_hash['feed']['entry'].each do |exp_data|
#   experience = Experience.find_by(ta_id: exp_data['gsx$experienceid']['$t'])
#   ta_votes = exp_data['gsx$nbfivestars']['$t'].to_i + exp_data['gsx$nbfourstars']['$t'].to_i + exp_data['gsx$nbthreestars']['$t'].to_i + exp_data['gsx$nbtwostars']['$t'].to_i + exp_data['gsx$nbonestars']['$t'].to_i
#   ta_rating = ((exp_data['gsx$nbfivestars']['$t'].to_i*5 + exp_data['gsx$nbfourstars']['$t'].to_i*4 + exp_data['gsx$nbthreestars']['$t'].to_i*3 + exp_data['gsx$nbtwostars']['$t'].to_i*2 + exp_data['gsx$nbonestars']['$t'].to_i*1).to_f / (exp_data['gsx$nbfivestars']['$t'].to_i + exp_data['gsx$nbfourstars']['$t'].to_i + exp_data['gsx$nbthreestars']['$t'].to_i + exp_data['gsx$nbtwostars']['$t'].to_i + exp_data['gsx$nbonestars']['$t'].to_i))
#   experience.update(
#     ta_votes: ta_votes,
#     ta_rating: ta_rating.round(2),
#     ta_url: exp_data['gsx$url']['$t']
#   )
#   experience.experience_reviews.create(
#     name: exp_data['gsx$commentonename']['$t'],
#     rating: exp_data['gsx$commentonescore']['$t'].to_i,
#     original_date: exp_data['gsx$commentonedate']['$t'],
#     comment: exp_data['gsx$commentonecontent']['$t']
#   )
#   experience.experience_reviews.create(
#     name: exp_data['gsx$commenttwoname']['$t'],
#     rating: exp_data['gsx$commenttwoscore']['$t'].to_i,
#     original_date: exp_data['gsx$commenttwodate']['$t'],
#     comment: exp_data['gsx$commenttwocontent']['$t']
#   )
#   experience.experience_reviews.create(
#     name: exp_data['gsx$commentthreename']['$t'],
#     rating: exp_data['gsx$commentthreescore']['$t'].to_i,
#     original_date: exp_data['gsx$commentthreedate']['$t'],
#     comment: exp_data['gsx$commentthreecontent']['$t']
#   )
# end


# New experiences Cuba
# require 'json'
# require 'rest_client'
# url_json = "https://spreadsheets.google.com/feeds/list/1VNjWN-IZpIdh7tMNk8nUxzvsprkd2twDGVyJn0fGvxA/od6/public/values?alt=json"
# data_hash = JSON.parse(RestClient.get(url_json))
# data_hash['feed']['entry'].each do |exp_data|
#   if exp_data['gsx$new']['$t'] == 'o'
#     exp = Experience.create(
#       average_rating: exp_data['gsx$rating']['$t'].to_f,
#       name: exp_data['gsx$nomfrench']['$t'],
#       address: exp_data['gsx$lieufrench']['$t'],
#       latitude: exp_data['gsx$coord']['$t'].split(", ")[0].to_f,
#       longitude: exp_data['gsx$coord']['$t'].split(", ")[1].to_f,
#       description: exp_data['gsx$descriptionfrench']['$t'],
#       onesentence: exp_data['gsx$onesentence']['$t'],
#       timetospent: exp_data['gsx$timetospent']['$t'],
#       wheretosleep: exp_data['gsx$wheretosleep']['$t'],
#       transportation: exp_data['gsx$transportation']['$t'],
#       published: true
#     )
#     exp.leader_reviews.create(
#       source: "Lonely Planet",
#       comment: exp_data['gsx$commentairelp']['$t'],
#     )
#     exp.leader_reviews.create(
#       source: "Guide Du Routard",
#       comment: exp_data['gsx$commentairegdr']['$t'],
#     )
#     gen_url = "http://philae-floju.s3.amazonaws.com/photos_cuba_new_exp/"
#     code = exp_data['gsx$code']['$t']
#     (1..4).each do |i|
#       complete_url = gen_url + code + "_#{i}.jpg"
#       begin
#         doc = open(complete_url)
#       rescue OpenURI::HTTPError
#         next
#       end
#       exp.experience_pictures.create(picture: complete_url)
#     end
#   end
# end


# Update experiences Cuba
# require 'json'
# require 'rest_client'
# url_json = 'https://spreadsheets.google.com/feeds/list/1aSeFG0CFAaI0C3bk05ipiEd3QG9MFiAr39ZLgDqruxg/od6/public/values?alt=json'
# data_hash = JSON.parse(RestClient.get(url_json))
# data_hash['feed']['entry'].each do |exp_data|
#   Experience.find(exp_data['gsx$experienceid']['$t'].to_i).update(
#     average_rating: exp_data['gsx$averagerating']['$t'].to_f,
#     description: exp_data['gsx$descriptionfrench']['$t'],
#     onesentence: exp_data['gsx$onesentence']['$t'],
#     timetospent: exp_data['gsx$timetospent']['$t'],
#     wheretosleep: exp_data['gsx$wheretosleep']['$t'],
#     transportation: exp_data['gsx$transportation']['$t'],
#     landing_point: exp_data['gsx$landingpoint']['$t']
#   )
# end

#Mise en ligne du temps à passer pour chaque experience
# require 'json'
# require 'rest_client'
# url_json = 'https://spreadsheets.google.com/feeds/list/1Occ1v2yJMLTLBS6HdzFaswNWhCwCR0NJKNSXAPgk4gE/od6/public/values?alt=json'
# data_hash = JSON.parse(RestClient.get(url_json))
# data_hash['feed']['entry'].each do |exp_data|
#   Experience.find(exp_data['gsx$experienceid']['$t'].to_i).update(timetospent: exp_data['gsx$timetospent']['$t'] )
# end

# Mise en ligne des landing_point
require 'json'
require 'rest_client'
url_json = 'https://spreadsheets.google.com/feeds/list/1lJKLSs0tXP5TQQSVat3SCvRXUKU1Yw6Qr6ejy4ISWSI/od6/public/values?alt=json'
data_hash = JSON.parse(RestClient.get(url_json))
data_hash['feed']['entry'].each do |exp_data|
  Experience.find(exp_data['gsx$experienceid']['$t'].to_i).update(landing_point: exp_data['gsx$landingpoint']['$t'] )
end



#Mise en ligne des avis du Routard
# require 'json'
# require 'rest_client'
# url_json = 'https://spreadsheets.google.com/feeds/list/1YimhH2yPPv7DBNulFNimHIFN2xCRZlNCqLP_Lladgk4/od6/public/values?alt=json'
# data_hash = JSON.parse(RestClient.get(url_json))
# data_hash['feed']['entry'].each do |leader_review|
#   leader_review = LeaderReview.create(
#     experience_id: leader_review['gsx$experienceid']['$t'].to_f,
#     source: leader_review['gsx$source']['$t'],
#     comment: leader_review['gsx$comment']['$t'],
#   )
# end


# Implémentation must-see et Liste des 1000 lieux à voir dans sa vie
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

# require 'json'
# require 'rest_client'
# url_json = 'https://spreadsheets.google.com/feeds/list/1yqaP4CpQUrI1gJGUuYmPqtIFGcclVM0BIX_T2xVrORQ/od6/public/values?alt=json'
# data_hash = JSON.parse(RestClient.get(url_json))
# data_hash['feed']['entry'].each do |exp_data|
#   Experience.find(exp_data['gsx$experienceid']['$t'].to_i).update(must_see: exp_data['gsx$mustsee']['$t'])
# end

# Mise à jour du lien Wikipedia
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
  # exp_review = ExperienceReview.create(
  #   experience_id: experience_review['gsx$experienceid']['$t'].to_f,
  #   name: experience_review['gsx$name']['$t'],
  #   rating: experience_review['gsx$rating']['$t'].to_f * 2,
  #   original_date: experience_review['gsx$originaldate']['$t'],
  #   comment: experience_review['gsx$comment']['$t']
  # )
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

