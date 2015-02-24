require 'cinch'
require 'httparty'
require 'json'
require 'googl'
require 'rest-client'
require 'open-uri'
require 'mediawiki_api'

BOT_NAME = 'ESAEBSAD'
OWNER_NAME = 'xbony2'

NICE_THINGS = ["I love you the way you are.", "You are doing great.", "You're awesome",
  "ERROR: so awesome I don't know what to do.", "I want you.", 
  "I would let you eat my butthole.", "I am unworthy of you eating my butthole.",
  "Fuck that, what about me?", "You're awesome, that's just it.", 
  "Your so awesome I forgot to grammar.", "You're almost as cool as Xbony2.",
  "I'm going to touch you when you aren't looking.", "Give yourself a pat on the back.",
  "It is a good day when you are here.", "You are my savior", "SatanicSanta is smelly"]
  
PASS_DIR = 'git/IRC-Bot/src/main/ruby/xbony2/ircbot/SEKRET_PASSWORD.confidentual'
DESKTOP_DIR = 'Desktop/'

API_PAGE = 'http://ftb.gamepedia.com/api.php'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.esper.net"
    c.channels = ["#NuclearControl2", "#FTB-Wiki"]
    c.nick = BOT_NAME
    
    WIKI_PASS = File.read(PASS_DIR)
    $wiki_bot = MediawikiApi::Client.new(API_PAGE)
    $wiki_bot.log_in(BOT_NAME, WIKI_PASS)
  end
  
  on :channel, "@@help" do |m|
    m.reply "Commands: @@help, @@flip, @@roll, @@dev, @@motivate, @@url-shorten and @@archive."
    m.reply "Admin only commands: @@stop, @@upload."
  end
  
  #Uploads file from the desktop
  on :channel, /^@@upload (.+)/ do |m, pic|
    if m.user.authname != OWNER_NAME
      m.reply "You are not authorized."
    else
      $wiki_bot.upload_image(pic, DESKTOP_DIR + pic, 
        "Contact #{OWNER_NAME} with any concerns about this picture.", true)
      m.reply "Picture uploaded: http://ftb.gamepedia.com/File:#{pic}"
    end
  end
  
  on :channel, /^@@archive (.+)/ do |m, site|
    open("http://web.archive.org/save/" + site)
    m.reply("Will be available here shortly: https://web.archive.org/web/*/" + site)
  end
  
  on :channel, "@@motivate" do |m|
    rand = Random.rand(NICE_THINGS.length)
    m.reply(NICE_THINGS.fetch(rand))
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
  
  # Protection
  on :channel, "#{OWNER_NAME} is ugly" do |m|
    if m.user.authname != OWNER_NAME
      m.reply "Shut the fuck up, #{m.user}. Your mom is ugly, but not as ugly as you are."
    else
      m.reply "Don't feel so bad about yourself ( ͡° ͜ʖ ͡°) u so sexy."
    end
  end
  
  on :channel, "#{BOT_NAME} is ugly" do |m|
    if m.user.authname != OWNER_NAME
          m.reply "Shut the fuck up, #{m.user}. Your mom is ugly, but not as ugly as you are."
        else
          m.reply "I'm sorry for ever showing my face ;_;"
        end
  end
  
  on :channel, "@@stop" do |m|
    if m.user.authname == OWNER_NAME
      exit # Terminates program
    else
      m.reply "You cannot stop me unless you're my creator."
    end 
  end
  
  # If the bot is kicked, the program stops
  on :leaving do |m, user|
    if user.nick == BOT_NAME
      exit
    end
  end
end

bot.start
