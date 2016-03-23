json.array!(@stories) do |story|
  json.extract! story, :id, :title, :content, :rating
  json.url story_url(story, format: :json)
end
