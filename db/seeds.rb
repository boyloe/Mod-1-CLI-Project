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
      response = RestClient.get("recipepuppy.com/api/?i=#{protein}")
      data = JSON.parse(response) 
      

      recipe_titles = data['results'].map do |result|
          result['title'].gsub("\n","")
      end

      new_recipe = prompt.select('Which recipe would you like to add?', recipe_titles)
      
      i = 0
      while i < data['results'].length do
        if data['results'][i]['title'].gsub("\n","") == new_recipe
          recipe_ingredients = data['results'][i]['ingredients']
          recipe_website = data['results'][i]['href']
          break
        else
            i += 1
        end
      end
      rec1 = Recipe.create(name: new_recipe, ingredients: recipe_ingredients)
      binding.pry
    end


