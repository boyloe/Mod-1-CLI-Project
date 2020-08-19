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

teryaki_beef = Recipe.create(name: "Beef Teryaki Recipe", ingredients: "beef, mirin, chicken broth, soy, sauce, teriyaki sauce, sugar, cornstarch, water")
grilled_italian_chicken = Recipe.create(name: "Grilled Italian Chicken Breasts", ingredients: "garlic, bread crumbs, chicken, butter")

UserRecipe.create(user: bradley , recipe: teryaki_beef)
UserRecipe.create(user: bryan , recipe: teryaki_beef)
UserRecipe.create(user: bryan , recipe: grilled_italian_chicken)

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


