require 'cinch'

BOT_NAME = "ESAEBSAD Bot"

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.esper.net"
    c.channels = ["#NuclearControl2"]
    c.nick = BOT_NAME
  end
  
  on :channel, /^@@help/ do |m|
    m.reply "Commands:"
    m.reply ": @@help -displays this message,"
    m.reply ": @@flip -flips a coin,"
    m.reply ": @@roll -rolls a die."
  end
  
  on :channel, /^@@flip/ do |m|
    result = 1 + rand(2)
    if result == 1
      m.reply "The coin flip reveals heads."
    else
      m.reply "The coin flip reveals tails."
    end
  end
  
  on :channel, /^@@roll/ do |m|
    result = 1 + rand(6)
    m.reply "The die roll reveals the number #{result}."
  end
  
  on :channel, /^@@stop/ do |m|
    if m.user.authname == "xbony2"
      exit
    else
      m.reply "You cannot stop me unless you're my owner."
    end 
  end
  
  on :leaving do |m, user|
    if user.nick == bot.nick
      exit
    end
  end
end

bot.start
