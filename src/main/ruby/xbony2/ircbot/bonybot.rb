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
    m.reply ": @@help -displays this message"
    m.reply ": @@flip -flips a coin"
  end
  
  on :channel, /^@@flip/ do |m|
    result = 1 + rand(2)
    if result == 1
      m.reply "The coin flip reveals heads."
    else
      m.reply "The coin flip reveals tails."
    end
  end
end

bot.start
