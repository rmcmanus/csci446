json.array!(@pets) do |pet|
  json.extract! pet, :id, :name, :age, :breed, :description, :habits, :image_url
  json.url pet_url(pet, format: :json)
end
