class Cli 

  attr_accessor :user
  
  def initialize user=nil
    @user = user
  end

  def self.login
    puts "Welcome to Recipe"
    sleep(2)
    puts "Please Enter your Username:"
    username = gets.strip
    system "clear"
    User.find_user username    
  end
  
      
      # fav_input = @user.favorites
      # fav_input.each do |fav|
      # favs_list << fav.recipe.name
      # end
      
    #   puts favs_list 
    #       prompt = TTY::Prompt.new
    #       favs_options = ["return to main menu", "delete"]
    #       response = prompt.select("Favorites", favs_options)
    #       case response
    #       when "return to main menu"
    #         menu
    #       when "delete"
    #         puts "Which favorite would you like to delete?"
    #         this_one = gets.strip
    #         found_fav = Recipe.find_by(name: this_one).id
    #         Favorite.find_by(recipe_id: found_fav, user_id: @user.id).destroy
    #         # system "clear"
    #         # main_menu
    #       end
    # end
    # def find_new_recipe 
    #   prompt = TTY::Prompt.new
    #   protein = prompt.select('What protein would you like?',%w(beef, pork, chicken, fish))
    #   cooking_style = prompt.select('How would you like that cooked', %w(Baked, Fried, Grilled, Poached))
    #   flavor = prompt.select('What flavoring would you like?', %w(Soy, Garlic, Lemon, Herbs,))
    # end
end 
    

     
