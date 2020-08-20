class UserRecipe < ActiveRecord::Base
    belongs_to :user
    belongs_to :recipe

    def self.favorite recipe_id, user_id

        new_fav = find_by(user_id: user_id, recipe_id: recipe_id)
        if new_fav.nil?
            new = UserRecipe.create(user_id: user_id, recipe_id: recipe_id)
        end
        binding.pry
    end

    def self.create_new_favorite ()
        
    end
    
end