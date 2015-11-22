class SayStuff < ESAEBSADCommand
  include Cinch::Plugin
  
  set_help "say", <<EOS
Group: owner. Syntax: "@@say (words)"
The say shorten command will say, as in through the speaker, the given string.
It will not work if ESAEBSAD is running on a non-OS X computer.
EOS
  set :prefix, /^@@/
  match /say (.+)/
  def execute(msg, words)
    if is_part_of_group? msg.user.authname, :owner
      if (ENV["OS"] == nil) and (RUBY_PLATFORM.end_with? "darwin14")
        Voice.say(words, :voice => 'Samantha')
      else
        msg.reply "#{OWNER_NAME}: the say command does not work on non-OS X operating systems."
        msg.reply "#{OWNER_NAME}: if my detector is incorrect, make sure to either fix it or report it."
      end
    else 
      msg.reply "You are not authorized."
    end
  end
end