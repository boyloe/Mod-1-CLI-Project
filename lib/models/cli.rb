class Cli 

  attr_accessor :user
  
  def initialize user=nil
    @user = user
  end

  def self.login

    AsciiArt.welcome_logo

    sleep(2)
    puts "Please Enter your Username:".cyan
    username = gets.strip
    system "clear"
    User.find_user username    
  end
end 
    

     
