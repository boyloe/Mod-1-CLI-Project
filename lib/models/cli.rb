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
 

  def menu 
      prompt = TTY::Prompt.new
      menu_options = ["find a recipe", "favorites", "exit"]
      menu_prompt = prompt.select("menu", menu_options)
      case menu_prompt      
      when "find a recipe" 
        # recipe_finder 
        proteins = ['chicken','beef','pork','fish']
        protein_prompt = prompt.select("What would you like to eat?",proteins)
        recipes = Recipe.where('ingredients LIKE ?', "%#{protein_prompt}%")
        recipe_names = recipes.map do |recipe|
          recipe.name
        end
        recipe_prompt = prompt.select("Found Recipes", recipe_names)
        binding.pry
        #Ask something here about adding to favorites, y/n?
        #Then call favorites if answer is yes
       

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
    # def find_new_recipe 
    #   prompt = TTY::Prompt.new
    #   protein = prompt.select('What protein would you like?',%w(beef, pork, chicken, fish))
    #   cooking_style = prompt.select('How would you like that cooked', %w(Baked, Fried, Grilled, Poached))
    #   flavor = prompt.select('What flavoring would you like?', %w(Soy, Garlic, Lemon, Herbs,))
    # end
end 
    

     
