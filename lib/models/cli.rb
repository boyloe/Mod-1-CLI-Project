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
      menu_options = ["create new recipe", "find a recipe", "favorites", "exit"]
      menu_prompt = prompt.select("menu", menu_options)
      case menu_selection
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

    def find_new_recipe 
      prompt = TTY::Prompt.new
      protein = prompt.select('What protein would you like?',%w(beef, pork, chicken, fish))
      cooking_style = prompt.select('How would you like that cooked', %w(Baked, Fried, Grilled, Poached))
      flavor = prompt.select('What flavoring would you like?', %w(Soy, Garlic, Lemon, Herbs,))
      response = RestClient.get("recipepuppy.com/api/?i=#{protein},#{flavor},#{cooking_style}")
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
end 
    

     
