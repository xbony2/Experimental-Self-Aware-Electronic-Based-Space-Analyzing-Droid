require 'cinch'
require 'httparty'
require 'json'
require 'googl'
require 'rest-client'

BOT_NAME = "ESAEBSAD"
NICE_THINGS = ["I love you the way you are.", "You are doing great.", "You're awesome",
  "ERROR: so awesome I don't know what to do.", "I want you.", 
  "I would let you eat my butthole.", "I am unworthy of you eating my butthole.",
  "Fuck that, what about me?", "You're awesome, that's just it.", 
  "Your so awesome I forgot to grammar.", "You're almost as cool as Xbony2.",
  "I'm going to touch you when you aren't looking.", "Give yourself a pat on the back.",
  "It is a good day when you are here.", "You are my savior", "SatanicSanta is smelly"]

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.esper.net"
    c.channels = ["#NuclearControl2", "#FTB-Wiki"]
    c.nick = BOT_NAME
  end
  
  on :channel, "@@help" do |m|
    m.reply "Commands: @@help, @@flip, @@roll, @@dev, @@motivate, @@url-shorten and @@spam."
  end
  
  on :channel, "@@motivate" do |m|
    ran = Random.rand(NICE_THINGS.length)
    m.reply NICE_THINGS.fetch(ran)
  end
  
  on :channel, "@@flip" do |m|
    if 1 + rand(2) == 1
      m.reply "The coin flip reveals heads."
    else
      m.reply "The coin flip reveals tails."
    end
  end
  
  on :channel, "@@roll" do |m|
    m.reply "The die roll reveals the number #{1 + rand(6)}."
  end
  
  on :channel, "@@dev" do |m|
    m.reply "I am an IRC bot created by xbony2 in Ruby, using the cinch gem."
    m.reply "I am open-sourced and under the MIT license: http://goo.gl/GkH1x1"
  end
  
  on :channel, /^@@url-shorten (.+)/ do |m, url|
    shortUrl = Googl.shorten(url)
    m.reply "New URL: #{shortUrl.short_url}"
  end
  
  on :channel, "@@spam" do |m|
    m.reply "I think you should know I'm better then that, #{m.user}."
  end
  
  on :channel, "xbony2 is ugly" do |m|
    if m.user.authname != "xbony2"
      m.reply "Shut the fuck up, #{m.user}. Your mom is ugly, but not as ugly as you are."
    else
      m.reply "Don't feel so bad about yourself ( ͡° ͜ʖ ͡°) u so sexy."
    end
  end
  
  on :channel, "ESAEBSAD is ugly" do |m|
    if m.user.authname != "xbony2"
          m.reply "Shut the fuck up, #{m.user}. Your mom is ugly, but not as ugly as you are."
        else
          m.reply "I'm sorry for ever showing my face ;_;"
        end
  end
  
  # This command is hidden by default, since only the owner needs to know about it.
  on :channel, "@@stop" do |m|
    if m.user.authname == "xbony2"
      exit # Terminates program
    else
      m.reply "You cannot stop me unless you're my creator."
    end 
  end
  
  # If the bot is kicked, the program stops
  on :leaving do |m, user|
    if user.nick == bot.nick
      exit
    end
  end
end

bot.start
