require 'cinch'

BOT_NAME = "ESAEBSAD Bot"

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.esper.net"
    c.channels = ["#NuclearControl2"]
    c.nick = BOT_NAME
  end

    # Only log channel messages
    on :channel do |m|
      $users[m.user.nick] = Seen.new(m.user.nick, m.channel, m.message, Time.new)
    end
  
    on :channel, /^!seen (.+)/ do |m, nick|
      if nick == bot.nick
        m.reply "That's me!"
      elsif nick == m.user.nick
        m.reply "That's you!"
      elsif $users.key?(nick)
        m.reply $users[nick].to_s
        m.reply "test"
      else
        m.reply "I haven't seen #{nick}"
      end
    end
end

bot.start
