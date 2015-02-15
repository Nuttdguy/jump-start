require 'jumpstart_auth'

class MicroBlogger
  attr_reader :client
  
  def initialize
    puts "Initializing MicroBlogger"
    @client = JumpstartAuth.twitter
  end
  
  def tweet(message)
    if message.length <= 140
      @client.update(message)
    else
      puts "Do not post tweet!"
    end
  end
  
  def followers_list
    screen_names = []
  end
  
  def spam_my_followers(message)
    list = followers_list
    dm(list, message)
  end
  
  def dm(target, message)
    puts "Trying to send #{target} this direct message:"
    puts message
    screen_names = @client.followers.collect { |follower| @client.user(follower).screen_name }   
    names = screen_names.join("")
    downcase_names = names.downcase
    downcase_target = target.downcase

    if downcase_target.include?(downcase_names)
      message = "d @#{target} #{message}"
      tweet(message)
    else 
      puts "You can only DM people who follow you silly!"
    end
  end
  
  def run
    puts "Welcome to the JSL Twitter Client!"
    command = ""
    while command != "q"
      printf "enter command: "
      input = gets.chomp
      parts = input.split(" ")
      command = parts[0]
      case command
      when 'q' then puts "Goodbye!"
      when 't' then puts tweet(parts[1..-1].join(" "))
      when 'dm' then dm(parts[1], parts[2..-1].join(" "))
      else
        puts "Sorry, I don't know how to #{command}"
      end
    end
  end
  
  blogger = MicroBlogger.new
  blogger.spam_my_followers("Who is this")
  blogger.run
end
