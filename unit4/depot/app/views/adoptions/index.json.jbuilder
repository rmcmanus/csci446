json.array!(@adoptions) do |adoption|
  json.extract! adoption, :id
  json.url adoption_url(adoption, format: :json)
end
