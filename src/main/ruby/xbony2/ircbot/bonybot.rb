require 'cinch'
require 'httparty'
require 'json'
require 'googl'
require 'rest-client'
require 'open-uri'
require 'mediawiki-butt'
require 'lyricfy'
require 'highline'
require 'nokogiri'
require 'voice'

require_relative 'plugins/help'
require_relative 'plugins/help_advanced'
require_relative 'plugins/trans'
require_relative 'plugins/addcat'
require_relative 'plugins/addriovarmor'
require_relative 'plugins/addcata'
require_relative 'plugins/lyrics'
require_relative 'plugins/quote'
require_relative 'plugins/motivate'
require_relative 'plugins/flirt'
require_relative 'plugins/say_stuff'
require_relative 'plugins/catmanipulator'
require_relative 'plugins/articleoftheweek'
require_relative 'plugins/info'

$BOT_NAME = 'ESAEBSAD'
$OWNER_NAME = 'xbony2'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.esper.net"
    c.channels = ["#NuclearControl2", "#FTB-Wiki", "FTB-Wiki-Dev"]
    c.nick = $BOT_NAME
    c.plugins.plugins = [Help, HelpAdvanced, Trans, AddCat, AddRiovArmor, AddCatA, Lyrics, Quote, Motivate, Flirt, SayStuff, CatManipulator, ArticleOfTheWeek, Info]
    
    $ftb_client = MediaWiki::Butt.new 'http://ftb.gamepedia.com'
    $ftb_client.login($BOT_NAME, File.read('git/IRC-Bot/src/main/resources/xbony2/ircbot/SEKRET_PASSWORD.confidentual'))
  end
  
  on :channel, /^@@archive (.+)/ do |m, site|
    open "http://web.archive.org/save/#{site}"
    m.reply "Will be available here shortly: https://web.archive.org/web/*/#{site}"
  end
  
  on :channel, "@@flip" do |m|
    m.reply "The coin flip reveals #{1 + rand(2) == 1? "heads" : "tails"}."
  end
  
  on :channel, "@@roll" do |m|
    m.reply "The die roll reveals the number #{1 + rand(6)}."
  end
  
  on :channel, "@@dev" do |m|
    m.reply "I am an IRC bot created by xbony2 in Ruby, using the cinch gem."
    m.reply "I am open-sourced and under the MIT license: http://goo.gl/GkH1x1"
  end
  
  on :channel, /^@@url-shorten (.+)/ do |m, url|
    m.reply "New URL: #{Googl.shorten(url).short_url}"
  end
  
  on :channel, "@@spam" do |m|
    m.reply "I think you should know I'm better then that, #{m.user}."
  end
  
  # Protection
  on :channel, "#{$OWNER_NAME} is ugly" do |m|
    if m.user.authname != $OWNER_NAME
      m.reply "Shut up, #{m.user}. Your mom is ugly, but not as ugly as you are."
    else
      m.reply "Don't feel so bad about yourself ( ͡° ͜ʖ ͡°) u so sexy."
    end
  end
  
  on :channel, "#{$BOT_NAME} is ugly" do |m|
    if m.user.authname != $OWNER_NAME
      m.reply "Shut the fuck up, #{m.user}. Your mom is ugly, but not as ugly as you are."
    else
      m.reply "I'm sorry for ever showing my face ;_;"
    end
  end
  
  on :channel, "@@stop" do |m|
    if m.user.authname == $OWNER_NAME
      exit
    else
      m.reply "You cannot stop me unless you're my creator."
    end 
  end
end

bot.start
