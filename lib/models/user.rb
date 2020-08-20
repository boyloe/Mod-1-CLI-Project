class User < ActiveRecord::Base
    has_many :user_recipes
    has_many :recipes, through: :user_recipes

    def self.find_user(user_input)
        # Search if user exists or not
        @user = all.find_by(username: user_input)

        # If user exists, bring user to main menu; else initiate User.create_user
        if @user
            prompt = TTY::Prompt.new
            system("clear")
            puts "Welcome back, #{@user.username}\n\n"
            sleep(1)            
            @user.menu              
        else
            create_new_user(user_input)
        end
    end

    def self.update_user         
        puts "What would you like to change your username to?"
        new_name = gets.strip        
        @user.update(username: new_name)
        puts "Your username has been updated."
        @user.menu
        
    end

    def self.create_new_user(user)
        
        @user = create(username: user)
        puts "Welcome to Recipe #{@user.username}"
        sleep(1)
        @user.menu    
    end

    def menu 
        prompt = TTY::Prompt.new
        menu_options = ["Find a New Recipe", "Show My Favorites","Update User", "Exit"]
        menu_prompt = prompt.select("How Can I Help You Today?\n", menu_options)
        case menu_prompt      
        when "Find a New Recipe" 
            proteins = ['chicken','beef','pork','fish']
            protein_prompt = prompt.select("What would you like to eat?",proteins)
            recipes = Recipe.where('ingredients LIKE ?', "%#{protein_prompt}%")
            recipe_names = recipes.map do |recipe|
                recipe.name
            end
            recipe_prompt = prompt.select("Found Recipes", recipe_names)
            
            if prompt.yes?('Do you want add this to your Favorites?')            
                add_favorites(recipe_prompt)
                
            else        
                menu    
            end
        
        when "Show My Favorites"
            sleep(1)
            list_favorites

        when "Update User"
            sleep(1)
            User.update_user

        when "Exit"
            puts "Goodbye #{self.name}!"
            sleep(2)
            system "exit"  
        end
    end

    def add_favorites(recipe_prompt)
        favorited_recipe = Recipe.find_by(name: recipe_prompt)
        UserRecipe.create_favorite_recipe(self, favorited_recipe)        
        list_favorites
    end

    def list_favorites        
        favorites = UserRecipe.get_user_favorites self
        recipe_names = favorites.map do |favorite|
            Recipe.find_by(id: favorite.recipe_id).name
        end
        prompt = TTY::Prompt.new
        favs_options = ["Delete a Recipe","Return to Main Menu"]
        response = prompt.select("\n\nWhat would you like to do?", favs_options)
        case response
            when "Return to Main Menu"
                sleep(1)
                system "clear"
                menu                
            when "Delete a Recipe"
                sleep(1)
                system "clear"
                recipe_to_delete = prompt.select("Which recipe do you want to delete?",recipe_names)                
                found_favorite = Recipe.find_by(name: recipe_to_delete).id
                UserRecipe.find_by(recipe_id: found_favorite, user_id: self).destroy
                sleep(1)
                system "clear"
                menu
        end
    end    
end

