require 'cinch'
require 'httparty'
require 'json'
require 'googl'
require 'rest-client'
require 'open-uri'
require 'mediawiki_api'
require 'lyricfy'
require 'highline'
require 'nokogiri'
require_relative 'ftb_wiki_client'

require_relative 'plugins/help'
require_relative 'plugins/help_advanced'
require_relative 'plugins/trans'
require_relative 'plugins/addcat'
require_relative 'plugins/addriovarmor'
require_relative 'plugins/addcata'

$BOT_NAME = 'ESAEBSAD'
$OWNER_NAME = 'xbony2'

NICE_THINGS = ["I love you the way you are.", "You are doing great.", "You're awesome",
  "ERROR: so awesome I don't know what to do.", "I want you.", 
  "I would let you eat my butthole.", "I am unworthy of you eating my butthole.",
  "Fuck that, what about me?", "You're awesome, that's just it.", 
  "Your so awesome I forgot to grammar.", "You're almost as cool as Xbony2.",
  "I'm going to touch you when you aren't looking.", "Give yourself a pat on the back.",
  "It is a good day when you are here.", "You are my savior", "SatanicSanta is smelly"]
  
RANDOM_QUOTES = ["\"FUCK YOU!\" - bitch-ass kid", "PrincessTwilightSparkle: I luff yew baby <3 Have my wixi babies",
  "wikislaves aren't suppose to die", "xbony2: You're the great and powerful trixie?", 
  "*enjoys the sensation of PrincessTwilightSparkle burping on his ass*", "Quick xbrony, dash! rainbow dash !",
  "\"My cat is bullying me. How do I fight him?\"", "All a girl wants is to be treated rough, god.", "[[What is love]]",
  "PaladinOne: Hydra can go [CENSORED] itself", "them ghasts have such wide holes ;)", "you must eat it so your cat isn't insulted",
  "IMMA INSERT MY EXTRA PENISES IN YOUR EARHOLES NOW", "NONE OF MY HOLES ARE SAFE", "EVERYTHING BUT THE BUTT", "My butt is nice tyvm",
  "I dream of being thrown around by a fry pan, dropping hot sticky loads of egg yolk on people", "we need more wiki-slaves",
  "xbony2: yer a scrub", "xbony2: hey bby, wanna fck?", "When I first discovered masturbation at Catholic school, I was terrified - I thought I was broken.",
  "I couldn't understand why jizz was coming out of my cock instead of my arsehole like it normally did."]
  
DESKTOP_DIR = 'Desktop/'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.esper.net"
    c.channels = ["#NuclearControl2", "#FTB-Wiki"]
    c.nick = $BOT_NAME
    c.plugins.plugins = [Help, Help_Advanced, Trans, Addcat, Addriovarmor, Addcata]
    
    WIKI_PASS = File.read('git/IRC-Bot/src/main/resources/xbony2/ircbot/SEKRET_PASSWORD.confidentual')
    $wiki_bot = MediawikiApi::Client.new('http://ftb.gamepedia.com/api.php')
    $wiki_bot.log_in($BOT_NAME, WIKI_PASS)
    $other_wiki_bot = FTB_Wiki_Client::WikiClient.new('http://ftb.gamepedia.com/api.php')
    
    $lyric_getter = Lyricfy::Fetcher.new
  end
  
  on :channel, /^@@lyrics (.*); (.*)/ do |m, artist, song|
    if m.user.authname != $OWNER_NAME #restricted because it's basically a spam machine
      m.reply "You are not authorized. Ask #{$OWNER_NAME} for any requests."
    else
      lyrics = $lyric_getter.search(artist, song).body.split("\\n")
      lyrics.each do |str|
        m.reply(str)
      end
    end
  end
  
  on :channel, /^@@upload (.+)/ do |m, pic|
    if m.user.authname != $OWNER_NAME
      m.reply "You are not authorized."
    else
      $wiki_bot.upload_image(pic, DESKTOP_DIR + pic, "Contact #{OWNER_NAME} with any concerns about this picture.", true)
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
  on :channel, "#{$OWNER_NAME} is ugly" do |m|
    if m.user.authname != OWNER_NAME
      m.reply "Shut up, #{m.user}. Your mom is ugly, but not as ugly as you are."
    else
      m.reply "Don't feel so bad about yourself ( ͡° ͜ʖ ͡°) u so sexy."
    end
  end
  
  on :channel, "#{$BOT_NAME} is ugly" do |m|
    if m.user.authname != OWNER_NAME
      m.reply "Shut the fuck up, #{m.user}. Your mom is ugly, but not as ugly as you are."
    else
      m.reply "I'm sorry for ever showing my face ;_;"
    end
  end
  
  on :channel, "@@stop" do |m|
    if m.user.authname == $OWNER_NAME
      exit # Terminates program
    else
      m.reply "You cannot stop me unless you're my creator."
    end 
  end
end

bot.start
