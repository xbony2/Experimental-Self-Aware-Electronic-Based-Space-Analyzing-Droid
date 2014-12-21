require 'cinch'

BOT_NAME = "ESAEBSAD Bot"

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.esper.net"
    c.channels = ["#NuclearControl2"]
    c.nick = BOT_NAME
  end
  
  on :channel, /^@@sayHi/ do |m|
    m.reply "Hello!"
  end
end

bot.start
