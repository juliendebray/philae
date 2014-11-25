json.array!(@experiences) do |experience|
  json.extract! experience, :id
  json.url experience_url(experience, format: :json)
end
