class User < ActiveRecord::Base
    has_many :user_recipes
    has_many :recipes, through: :user_recipes

    def self.find_user(user_input)
        # Search if user exists or not
        @user = all.find_by(username: user_input)

        # Conditional statement: If user exists, bring user to main menu; else initiate User.create_user
        if @user
            prompt = TTY::Prompt.new
            system("clear")
            puts "Welcome back, #{@user.username}"
            update = prompt.ask('Would you like to update your username?')
            if update
                update_user
            else 
                @user.menu   
            end
            
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
        binding.pry
    end

    def self.create_new_user(user)
        binding.pry
        @user = create(username: user)
        puts "Welcome to Recipe #{@user.username}"
        @user.menu    
    end

    def menu 
        prompt = TTY::Prompt.new
        menu_options = ["find a recipe", "favorites", "exit"]
        menu_prompt = prompt.select("menu", menu_options)
        case menu_prompt      
        when "find a recipe" 
          proteins = ['chicken','beef','pork','fish']
          protein_prompt = prompt.select("What would you like to eat?",proteins)
          recipes = Recipe.where('ingredients LIKE ?', "%#{protein_prompt}%")
          recipe_names = recipes.map do |recipe|
            recipe.name
          end
          recipe_prompt = prompt.select("Found Recipes", recipe_names)
          
          if prompt.yes?('Do you want add this to your Favorites?')            
             add_favorites(recipe_prompt)
             binding.pry
          else        
             menu    
          end
        
        when "favorites"
            list_favorites
        
        when "exit"
            system "exit"    

        end
    end

    def add_favorites(recipe_prompt)
        favorited_recipe = Recipe.find_by(name: recipe_prompt)
        UserRecipe.create_favorite_recipe(self, favorited_recipe)
        
        list_favorites
    end

    def list_favorites
        UserRecipe.get_user_favorites self
        prompt = TTY::Prompt.new
        favs_options = ["return to main menu", "delete"]
        response = prompt.select("Favorites", favs_options)
        case response
            when "return to main menu"
                menu
            when "delete"
                puts "Which favorite would you like to delete?"
                this_one = gets.strip
                found_fav = Recipe.find_by(name: this_one).id
                UserRecipe.find_by(recipe_id: found_fav, user_id: @user.id).destroy
        # system "clear"
        # main_menu
        end
    end    
end

