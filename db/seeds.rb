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

beefteriyaki = Recipe.create(name: "Beef Teryaki", ingredients: "Beef")
chickennuggets = Recipe.create(name: "Chicken Nuggets", ingredients: "Chicken, Salt")

UserRecipe.create(user: bradley , recipe: beefteriyaki)
UserRecipe.create(user: bryan , recipe: beefteriyaki)
UserRecipe.create(user: bryan , recipe: chickennuggets)



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


