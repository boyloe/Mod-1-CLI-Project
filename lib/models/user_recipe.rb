class UserRecipe < ActiveRecord::Base
    belongs_to :user
    belongs_to :recipe

  
    
    def self.create_favorite_recipe(user, recipe)
        favorite = find_by(user_id: user.id, recipe_id: recipe.id)
        if !favorite
            UserRecipe.create(user_id: user.id, recipe_id: recipe.id)
            puts "Recipe has been saved"
            binding.pry
            menu
        else
            puts "This recipe is already in your favorites list!"
            binding.pry
            system "clear"
            menu    
        end
    end

    def self.get_user_favorites username
        favorite_recipes = []
        user_id = username.id
        favorites = UserRecipe.where(user_id: user_id)
        favorites.map do |favorite|
            puts favorite.recipe.name
            favorite_recipes << favorite

            
        end
        favorite_recipes
    end

    
end