class Cli 

  attr_accessor :user
  
  def initialize user=nil
    @user = user
  end

  def self.login
    puts "Welcome to Recipe!"
    sleep(2)
    puts "Please Enter your Username:"
    username = gets.strip
    system "clear"
    User.find_user username    
  end
end 
    

     
