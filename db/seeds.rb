# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# !!!!!!!!_______________W_A_R_N_I_N_G____________________________!!!!!!!!
# LOCAL USE ONLY -> Generate pictures after import_from_heroku
# Never push this block uncommented to github or heroku
# ExperiencePicture.all.each do |exp_pic|
#   exp_pic.update(picture: exp_pic.picture.url.gsub("\/development\/", "\/production\/"))
# end
# DestinationPicture.all.each do |dest_pic|
#   dest_pic.update(picture: dest_pic.picture.url.gsub("\/development\/", "\/production\/"))
# end
# RecommendedTrip.all.each do |reco_trip|
#   reco_trip.update(picture: reco_trip.picture.url.gsub("\/development\/", "\/production\/")) unless reco_trip.picture.url.include?('missing')
# end
# !!!!!!!!_________________________________________________________!!!!!!!!

#Update categories from terminal
# Experience.where(published: true, landing_point: false, country_code: 'MX').each do |e|
#   puts e.id
#   puts e.name
#   puts e.description
#   puts e.category_tab
#   input = gets.chomp.split(", ")
#   e.update(category_tab: input)
# end



# Update experiences
require 'json'
require 'rest_client'
url_json = 'https://spreadsheets.google.com/feeds/list/1fAehN-kU04f1Kw5MWbRkv9wLRhHIsS9-tQ79hd50H9o/od6/public/values?alt=json'
data_hash = JSON.parse(RestClient.get(url_json))
data_hash['feed']['entry'].each do |exp_data|
  Experience.find(exp_data['gsx$experienceid']['$t'].to_i).update(
    country_code: exp_data['gsx$countrycode']['$t'],
    name: exp_data['gsx$name']['$t'],
    average_rating: exp_data['gsx$averagerating']['$t'].to_f,
    description: exp_data['gsx$descriptionfrench']['$t'],
    onesentence: exp_data['gsx$onesentence']['$t'],
    timetospent: exp_data['gsx$timetospent']['$t'],
    wheretosleep: exp_data['gsx$wheretosleep']['$t'],
    transportation: exp_data['gsx$transportation']['$t'],
    category_tab: exp_data['gsx$categorytab']['$t'].split(", "),
    landing_point: exp_data['gsx$landingpoint']['$t'],
    latitude: exp_data['gsx$latlng']['$t'].split(", ")[0].to_f,
    longitude: exp_data['gsx$latlng']['$t'].split(", ")[1].to_f,
    wikipedia_link: exp_data['gsx$wikipedialink']['$t'],
    must_see: exp_data['gsx$mustsee']['$t'],
    unesco: exp_data['gsx$unesco']['$t'],
    thousand_places: exp_data['gsx$thousandplaces']['$t'],
    published: exp_data['gsx$published']['$t']
  )
end

# Seed create recommended_trips
# require 'json'
# require 'rest_client'
# url_json = 'https://spreadsheets.google.com/feeds/list/15yPzyaqyZE8DUUMPq4pbQQhPAOaH-EMXU4qiYe-_i7I/od6/public/values?alt=json'
# data_hash = JSON.parse(RestClient.get(url_json))
# data_hash['feed']['entry'].each do |rec_trip|
#   recommended_trip = RecommendedTrip.create(
#     destination_id: Destination.find_by(country_code:'MX').id,
#     title: rec_trip['gsx$title']['$t'],
#     description: rec_trip['gsx$description']['$t'],
#     step_1: rec_trip['gsx$step1']['$t'],
#     step_2: rec_trip['gsx$step2']['$t'],
#     step_3: rec_trip['gsx$step3']['$t'],
#     step_4: rec_trip['gsx$step4']['$t'],
#     step_5: rec_trip['gsx$step5']['$t'],
#     step_6: rec_trip['gsx$step6']['$t'],
#     step_7: rec_trip['gsx$step7']['$t'],
#     step_8: rec_trip['gsx$step8']['$t'],
#     step_9: rec_trip['gsx$step9']['$t'],
#     step_10: rec_trip['gsx$step10']['$t'],
#     step_11: rec_trip['gsx$step11']['$t'],
#     step_12: rec_trip['gsx$step12']['$t'],
#     step_13: rec_trip['gsx$step13']['$t'],
#     step_14: rec_trip['gsx$step14']['$t'],
#     step_15: rec_trip['gsx$step15']['$t'],
#     picture: "https://philae-floju.s3.amazonaws.com/itineraires_mexique/"+ rec_trip['gsx$picturename']['$t'] + ".png"
#   )
#   rec_trip['gsx$recotripexptab']['$t'].split(", ").each_with_index do |v, i|
#     recommended_trip.recommended_trip_experiences.create(
#       experience_id: v.to_i,
#       order: 1 + i.to_i
#     )
#   end

  # RecommendedTripExperience.create(
  #     recommended_trip_id: rec_trip_exp['gsx$recommendedtripid']['$t'].to_i,
  #     experience_id: rec_trip_exp['gsx$experienceid']['$t'],
  #     order: rec_trip_exp['gsx$order']['$t'].to_i
  #   )
  # end

# Seed new experiences for Mexico
# require 'json'
# require 'rest_client'
# url_json = "https://spreadsheets.google.com/feeds/list/10D9p73yHIZVKqMRRedOo1JiHouD-FJVfkzZeb6KDG0Q/od6/public/values?alt=json"
# data_hash = JSON.parse(RestClient.get(url_json))
# data_hash['feed']['entry'].each do |exp_data|
#   exp = Experience.create(
#     average_rating: exp_data['gsx$averagerating']['$t'].to_f,
#     name: exp_data['gsx$name']['$t'],
#     address: exp_data['gsx$address']['$t'],
#     latitude: exp_data['gsx$latlng']['$t'].split(", ")[0].to_f,
#     longitude: exp_data['gsx$latlng']['$t'].split(", ")[1].to_f,
#     description: exp_data['gsx$description']['$t'],
#     timetospent: exp_data['gsx$timetospent']['$t'],
#     country_code: 'MX',
#     wikipedia_link: exp_data['gsx$wikipedialink']['$t'],
#     published: true
#   )
#   if exp_data['gsx$lpreview']['$t'].length > 0
#     exp.leader_reviews.create(
#       source: "Lonely Planet",
#       comment: exp_data['gsx$lpreview']['$t'],
#     )
#   end
#   if exp_data['gsx$gdrreview']['$t'].length > 0
#     exp.leader_reviews.create(
#       source: "Guide Du Routard",
#       comment: exp_data['gsx$gdrreview']['$t'],
#     )
#   end
#   gen_url = "https://philae-floju.s3.amazonaws.com/photos_mexique_new_exp/"
#   # complete_url = gen_url + exp_data['gsx$pictureone']['$t']
#   exp.experience_pictures.create(picture: gen_url + exp_data['gsx$pictureone']['$t'] + '.jpg')
#   exp.experience_pictures.create(picture: gen_url + exp_data['gsx$picturetwo']['$t'] + '.jpg')
#   exp.experience_pictures.create(picture: gen_url + exp_data['gsx$picturethree']['$t'] + '.jpg')
  # code = exp_data['gsx$code']['$t']
  # (1..4).each do |i|
  #   complete_url = gen_url + code + "_#{i}.jpg"
  #   begin
  #     doc = open(complete_url)
  #   rescue OpenURI::HTTPError
  #     next
  #   end
  #   exp.experience_pictures.create(picture: complete_url)
  # end
# end

# Seed  experiences with trip advisor
# require 'json'
# require 'rest_client'
# Update Cuba's experiences with ta id
# url_json = "https://spreadsheets.google.com/feeds/list/1VNjWN-IZpIdh7tMNk8nUxzvsprkd2twDGVyJn0fGvxA/od6/public/values?alt=json"
# data_hash = JSON.parse(RestClient.get(url_json))
# data_hash['feed']['entry'].each do |exp_data|
#   if exp_data['gsx$taid']['$t'] && exp_data['gsx$taid']['$t'].length > 0
#     exp = Experience.find_by(onesentence: exp_data['gsx$onesentence']['$t'])
#     exp.update(ta_id: exp_data['gsx$taid']['$t'])
#   end
# end
# Update Cuba's experiences with ta ratings and comments
# url_json = "https://spreadsheets.google.com/feeds/list/1rQ8RaI66PmtdvarLSPOl3C4LKV2Wcapg41V86vJXcSc/od6/public/values?alt=json"
# data_hash = JSON.parse(RestClient.get(url_json))
# tab = []
# data_hash['feed']['entry'].each do |exp_data|
#   experience = Experience.find(exp_data['gsx$experienceid']['$t'].to_i)
#   ta_votes = exp_data['gsx$nbfivestars']['$t'].to_i + exp_data['gsx$nbfourstars']['$t'].to_i + exp_data['gsx$nbthreestars']['$t'].to_i + exp_data['gsx$nbtwostars']['$t'].to_i + exp_data['gsx$nbonestars']['$t'].to_i
#   ta_rating = ((exp_data['gsx$nbfivestars']['$t'].to_i*5 + exp_data['gsx$nbfourstars']['$t'].to_i*4 + exp_data['gsx$nbthreestars']['$t'].to_i*3 + exp_data['gsx$nbtwostars']['$t'].to_i*2 + exp_data['gsx$nbonestars']['$t'].to_i*1).to_f / (exp_data['gsx$nbfivestars']['$t'].to_i + exp_data['gsx$nbfourstars']['$t'].to_i + exp_data['gsx$nbthreestars']['$t'].to_i + exp_data['gsx$nbtwostars']['$t'].to_i + exp_data['gsx$nbonestars']['$t'].to_i))
#   experience.update(
#     ta_id: exp_data['gsx$experiencetaid']['$t'],
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

# Mise en ligne des experiences = landing_point
# require 'json'
# require 'rest_client'
# url_json = 'https://spreadsheets.google.com/feeds/list/1lJKLSs0tXP5TQQSVat3SCvRXUKU1Yw6Qr6ejy4ISWSI/od6/public/values?alt=json'
# data_hash = JSON.parse(RestClient.get(url_json))
# data_hash['feed']['entry'].each do |exp_data|
#   Experience.find(exp_data['gsx$experienceid']['$t'].to_i).update(landing_point: exp_data['gsx$landingpoint']['$t'] )
# end

# Mise en ligne des landing_point
# require 'json'
# require 'rest_client'
# url_json = 'https://spreadsheets.google.com/feeds/list/1D1iZrRVEGdco6_FAeSI7btcWH3Z43x9uV199qWniTj0/od6/public/values?alt=json'
# data_hash = JSON.parse(RestClient.get(url_json))
# data_hash['feed']['entry'].each do |exp_data|
#   exp = Experience.create(
#     name: exp_data['gsx$nomfrench']['$t'],
#     latitude: exp_data['gsx$coord']['$t'].split(", ")[0].to_f,
#     longitude: exp_data['gsx$coord']['$t'].split(", ")[1].to_f,
#     landing_point: exp_data['gsx$landingpoint']['$t'],
#     published: true
#   )
# end

# Mise en ligne des avis du Routard
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


# Seed recommended_trip_experiences
# require 'json'
# require 'rest_client'
# url_json = 'https://spreadsheets.google.com/feeds/list/1lNzMqUvKF8kZ2iH_Rs-_gOVCMR-ZGtLMewwaFo255BQ/od6/public/values?alt=json'
# data_hash = JSON.parse(RestClient.get(url_json))
# data_hash['feed']['entry'].each do |rec_trip_exp|
#   rec_trip_exp = RecommendedTripExperience.create(
#     recommended_trip_id: rec_trip_exp['gsx$recommendedtripid']['$t'].to_i,
#     experience_id: rec_trip_exp['gsx$experienceid']['$t'],
#     order: rec_trip_exp['gsx$order']['$t'].to_i
#   )
# end

# Seed create recommended_trips
# require 'json'
# require 'rest_client'
# url_json = 'https://spreadsheets.google.com/feeds/list/1Wpmu-trbmTKVsDap3Ap0hW9mZG5qZa8--s9qrVUltv8/od6/public/values?alt=json'
# data_hash = JSON.parse(RestClient.get(url_json))
# data_hash['feed']['entry'].each do |rec_trip|
#   rec_trip = RecommendedTrip.create(
#     destination_id: rec_trip['gsx$destinationid']['$t'].to_i,
#     title: rec_trip['gsx$title']['$t'],
#     description: rec_trip['gsx$description']['$t'],
#     step_1: rec_trip['gsx$step1']['$t'],
#     step_2: rec_trip['gsx$step2']['$t'],
#     step_3: rec_trip['gsx$step3']['$t'],
#     step_4: rec_trip['gsx$step4']['$t'],
#     step_5: rec_trip['gsx$step5']['$t'],
#     step_6: rec_trip['gsx$step6']['$t'],
#     step_7: rec_trip['gsx$step7']['$t'],
#     step_8: rec_trip['gsx$step8']['$t'],
#     step_9: rec_trip['gsx$step9']['$t'],
#     step_10: rec_trip['gsx$step10']['$t'],
#     step_11: rec_trip['gsx$step11']['$t'],
#     step_12: rec_trip['gsx$step12']['$t'],
#     step_13: rec_trip['gsx$step13']['$t'],
#     step_14: rec_trip['gsx$step14']['$t'],
#     step_15: rec_trip['gsx$step15']['$t']
#   )
# end

# Seed update recommended_trips
# require 'json'
# require 'rest_client'
# url_json = 'https://spreadsheets.google.com/feeds/list/1Wpmu-trbmTKVsDap3Ap0hW9mZG5qZa8--s9qrVUltv8/od6/public/values?alt=json'
# data_hash = JSON.parse(RestClient.get(url_json))
# data_hash['feed']['entry'].each do |rec_trip|
#   RecommendedTrip.find(rec_trip['gsx$recommendedtripid']['$t'].to_i).update(
#     destination_id: rec_trip['gsx$destinationid']['$t'].to_i,
#     title: rec_trip['gsx$title']['$t'],
#     description: rec_trip['gsx$description']['$t'],
#     step_1: rec_trip['gsx$step1']['$t'],
#     step_2: rec_trip['gsx$step2']['$t'],
#     step_3: rec_trip['gsx$step3']['$t'],
#     step_4: rec_trip['gsx$step4']['$t'],
#     step_5: rec_trip['gsx$step5']['$t'],
#     step_6: rec_trip['gsx$step6']['$t'],
#     step_7: rec_trip['gsx$step7']['$t'],
#     step_8: rec_trip['gsx$step8']['$t'],
#     step_9: rec_trip['gsx$step9']['$t'],
#     step_10: rec_trip['gsx$step10']['$t'],
#     step_11: rec_trip['gsx$step11']['$t'],
#     step_12: rec_trip['gsx$step12']['$t'],
#     step_13: rec_trip['gsx$step13']['$t'],
#     step_14: rec_trip['gsx$step14']['$t'],
#     step_15: rec_trip['gsx$step15']['$t']
#   )
# end

# Seed recommended_trip_experiences
# require 'json'
# require 'rest_client'
# url_json = 'https://spreadsheets.google.com/feeds/list/1lNzMqUvKF8kZ2iH_Rs-_gOVCMR-ZGtLMewwaFo255BQ/od6/public/values?alt=json'
# data_hash = JSON.parse(RestClient.get(url_json))
# data_hash['feed']['entry'].each do |rec_trip_exp|
#   rec_trip_exp = RecommendedTripExperience.create(
#     recommended_trip_id: rec_trip_exp['gsx$recommendedtripid']['$t'].to_i,
#     experience_id: rec_trip_exp['gsx$experienceid']['$t'],
#     order: rec_trip_exp['gsx$order']['$t'].to_i
#   )
# end

# Update recommended_trip_experiences
# require 'json'
# require 'rest_client'
# url_json = 'https://spreadsheets.google.com/feeds/list/1lNzMqUvKF8kZ2iH_Rs-_gOVCMR-ZGtLMewwaFo255BQ/od6/public/values?alt=json'
# data_hash = JSON.parse(RestClient.get(url_json))
# data_hash['feed']['entry'].each do |rec_trip_exp|
#   RecommendedTripExperience.find(rec_trip_exp['gsx$recommendedtripexperienceid']['$t'].to_i).update(
#     recommended_trip_id: rec_trip_exp['gsx$recommendedtripid']['$t'].to_i,
#     experience_id: rec_trip_exp['gsx$experienceid']['$t'],
#     order: rec_trip_exp['gsx$order']['$t'].to_i
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

#update Destination Liban
# require 'json'
# require 'rest_client'
# url_json = 'https://spreadsheets.google.com/feeds/list/1f5WSB7ew6aCspE1IysJ3RYZiCqeOjJBYZ-UYzzEBR18/od6/public/values?alt=json'
# data_hash = JSON.parse(RestClient.get(url_json))
# data_hash['feed']['entry'].each do |dest_data|
#   Destination.find(dest_data['gsx$destinationid']['$t'].to_i).update(
#     intro_title: dest_data['gsx$introtitle']['$t'],
#     sentence1: dest_data['gsx$sentence1']['$t'],
#     sentence2: dest_data['gsx$sentence2']['$t'],
#     sentence3: dest_data['gsx$sentence3']['$t'],
#     sentence4: dest_data['gsx$sentence4']['$t'],
#     sentence5: dest_data['gsx$sentence5']['$t'],
#     enter_title: dest_data['gsx$entertitle']['$t'],
#     enter_line1: dest_data['gsx$enterline1']['$t'],
#     enter_line2: dest_data['gsx$enterline2']['$t'],
#     enter_line3: dest_data['gsx$enterline3']['$t'],
#     visit_time_title: dest_data['gsx$visittimetitle']['$t'],
#     visit_line1: dest_data['gsx$visitline1']['$t'],
#     visit_line2: dest_data['gsx$visitline2']['$t'],
#     visit_line3: dest_data['gsx$visitline3']['$t'],
#     security_title: dest_data['gsx$securitytitle']['$t'],
#     security_line1: dest_data['gsx$securityline1']['$t'],
#     security_line2: dest_data['gsx$securityline2']['$t'],
#     transport_title: dest_data['gsx$transporttitle']['$t'],
#     transport_line1: dest_data['gsx$transportline1']['$t'],
#     transport_line2: dest_data['gsx$transportline2']['$t'],
#     transport_line3: dest_data['gsx$transportline3']['$t'],
#     transport_line4: dest_data['gsx$transportline4']['$t'],
#     transport_line5: dest_data['gsx$transportline5']['$t'],
#     toknow_title: dest_data['gsx$toknowtitle']['$t'],
#     toknow_line1: dest_data['gsx$toknowline1']['$t'],
#     toknow_line2: dest_data['gsx$toknowline2']['$t'],
#     toknow_line3: dest_data['gsx$toknowline3']['$t'],
#     toknow_line4: dest_data['gsx$toknowline4']['$t'],
#     toknow_line5: dest_data['gsx$toknowline5']['$t'],
#   )
# end


#create Destination
# require 'json'
# require 'rest_client'
# url_json = 'https://spreadsheets.google.com/feeds/list/1m31RmoiMAI_fdjLnHISsgP4OTGZCGFBbcMYfM5FsphQ/od6/public/values?alt=json'
# data_hash = JSON.parse(RestClient.get(url_json))
# data_hash['feed']['entry'].each do |dest_data|
#   destination = Destination.create(
#     name: dest_data['gsx$name']['$t'],
#     ne_lat: dest_data['gsx$nelat']['$t'].to_f,
#     ne_lng: dest_data['gsx$nelng']['$t'].to_f,
#     sw_lat: dest_data['gsx$swlat']['$t'].to_f,
#     sw_lng: dest_data['gsx$swlng']['$t'].to_f,
#     intro_title: dest_data['gsx$introtitle']['$t'],
#     sentence1: dest_data['gsx$sentence1']['$t'],
#     sentence2: dest_data['gsx$sentence2']['$t'],
#     sentence3: dest_data['gsx$sentence3']['$t'],
#     sentence4: dest_data['gsx$sentence4']['$t'],
#     sentence5: dest_data['gsx$sentence5']['$t'],
#     enter_title: dest_data['gsx$entertitle']['$t'],
#     enter_line1: dest_data['gsx$enterline1']['$t'],
#     enter_line2: dest_data['gsx$enterline2']['$t'],
#     enter_line3: dest_data['gsx$enterline3']['$t'],
#     visit_time_title: dest_data['gsx$visittimetitle']['$t'],
#     visit_line1: dest_data['gsx$visitline1']['$t'],
#     visit_line2: dest_data['gsx$visitline2']['$t'],
#     visit_line3: dest_data['gsx$visitline3']['$t'],
#     security_title: dest_data['gsx$securitytitle']['$t'],
#     security_line1: dest_data['gsx$securityline1']['$t'],
#     security_line2: dest_data['gsx$securityline2']['$t'],
#     security_line3: dest_data['gsx$securityline3']['$t'],
#     transport_title: dest_data['gsx$transporttitle']['$t'],
#     transport_line1: dest_data['gsx$transportline1']['$t'],
#     transport_line2: dest_data['gsx$transportline2']['$t'],
#     transport_line3: dest_data['gsx$transportline3']['$t'],
#     transport_line4: dest_data['gsx$transportline4']['$t'],
#     transport_line5: dest_data['gsx$transportline5']['$t'],
#     toknow_title: dest_data['gsx$toknowtitle']['$t'],
#     toknow_line1: dest_data['gsx$toknowline1']['$t'],
#     toknow_line2: dest_data['gsx$toknowline2']['$t'],
#     toknow_line3: dest_data['gsx$toknowline3']['$t'],
#     toknow_line4: dest_data['gsx$toknowline4']['$t'],
#     toknow_line5: dest_data['gsx$toknowline5']['$t'],
#   )
#   gen_url = "http://philae-floju.s3.amazonaws.com/photos_thailande/"
#   name = dest_data['gsx$name']['$t']
#   (1..4).each do |i|
#     complete_url = gen_url + "thailande_#{i}.jpg"
#     begin
#       doc = open(complete_url)
#     rescue OpenURI::HTTPError
#       next
#     end
#     destination.destination_pictures.create(picture: complete_url)
#   end
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

