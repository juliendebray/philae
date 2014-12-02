Geocoder.configure(
  lookup:    :google,
  api_key:   ENV['GOOGLE_API_KEY'],
  use_https: true,
  units:     :km
)

puts "---------"
puts ENV['GOOGLE_API_KEY']
puts "---------"