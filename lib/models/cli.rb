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

    # def Menu 