require 'rest-client'
require 'json'
require 'pry'

User.destroy_all
Recipe.destroy_all
UserRecipe.destroy_all


response = RestClient.get("https://api.edamam.com/search?q=chicken&app_id=321076cb&app_key=6dd56cb4f4320dffe50f4b2fcaf529bd")

data = JSON.parse(response)
#use enumerables to map through data to find what you want to get
#in the map, you can call the .create method and save to database
#Character.create

# https://api.edamam.com/search?q=chicken&app_id=${321076cb}&app_key=${6dd56cb4f4320dffe50f4b2fcaf529bdYOUR_APP_KEY}
binding.pry