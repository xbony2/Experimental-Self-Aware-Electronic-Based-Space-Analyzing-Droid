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
require 'require_all'

require_relative 'esaebsadcommand'
require_rel 'plugins'

$BOT_NAME = 'ESAEBSAD'
$OWNER_NAME = 'xbony2'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.esper.net"
    c.channels = ["#NuclearControl2", "#FTB-Wiki", "#FTB-Wiki-Dev"]
    c.nick = $BOT_NAME
    c.plugins.plugins = $sub_classes
    
    $ftb_client = MediaWiki::Butt.new 'http://ftb.gamepedia.com'
    $br_client = MediaWiki::Butt.new 'http://minecraft-br.gamepedia.com'
    
    $ftb_client.login($BOT_NAME, File.read('git/IRC-Bot/lib/resources/SEKRET_PASSWORD.confidentual'))
    $br_client.login($BOT_NAME, File.read('git/IRC-Bot/lib/resources/SEKRET_PASSWORD.confidentual'))
  end
end

bot.start
