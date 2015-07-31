class Say_Stuff
  include Cinch::Plugin
  
  set :prefix, /^@@/
  match /say (.+)/
  def execute(msg, words)
    if msg.user.authname == $OWNER_NAME
      if (ENV['OS'] == nil) and (RUBY_PLATFORM.end_with? "darwin14")
        Voice.say(words)
      else
        msg.reply "#{OWNER_NAME}: the say command does not work on non-OS X operating systems."
        msg.reply "#{OWNER_NAME}: if my detector is incorrect, make sure to either fix it or report it."
      end
    else 
      msg.reply "You are not authorized."
    end
  end
end