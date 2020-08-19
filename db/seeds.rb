require 'rest-client'
require 'json'
require 'pry'




# #use enumerables to map through data to find what you want to get
# #in the map, you can call the .create method and save to database
# #Character.create

User.destroy_all
Recipe.destroy_all
UserRecipe.destroy_all

bryan = User.create(username: 'Bryan')
bradley = User.create(username: 'Bradley')

UserRecipe.create(user: bradley , recipe: Recipe.first)
UserRecipe.create(user: bryan , recipe: Recipe.first)
UserRecipe.create(user: bryan , recipe: Recipe.second)

def get_recipes
    proteins = ['chicken', 'beef','pork','fish']
    proteins.map do |protein|
        response = RestClient.get("recipepuppy.com/api/?q=#{protein}")
        data = JSON.parse(response) 
        data['results'].map do |result|
            recipe_name = result['title']
            recipe_ingredients= result['ingredients']
            Recipe.create(name: recipe_name, ingredients: recipe_ingredients)
        end
    end
end
get_recipes


