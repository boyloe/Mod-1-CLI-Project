class Cli 

    attr_accessor :user
  
    def initialize user=nil
      @user = user
    end
  
    def login
      puts "Welcome to Recipe"
      sleep(2)
      puts "Enter your Username"
      username = gets.strip
      system "clear"
      @user = User.find_by(username: username)
      if @user
          puts "Welcome back #{@user.username}"
      else
        @user = User.create(username: username)
        puts "Welcome to Recipe #{username}"
      end
    end
end 

    def menu 
        prompt = TTY::Prompt.new
        menu_options = ["create new recipe", "find a recipe", "favorites", "exit"]
            menu_prompt = prompt.select("menu", menu_options)
            case menu_options
            when "create new recipe"
              create_recipe
            
            when "find a recipe" 
              recipe_finder 

            when "favorites"
              favorites_list

            when "exit"
              system "exit"
            end
        end

        def favorites 
            favs_list = []
            fav_input = @user.favorites
            fav_input.each do |fav|
                favs_list << fav.recipe.name
            end
            puts favs_list 
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
                  Favorite.find_by(recipe_id: found_fav, user_id: @user.id).destroy
                  # system "clear"
                  # main_menu
                end
        end 
    

     
