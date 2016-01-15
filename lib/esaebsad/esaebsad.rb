require "cinch"
require "httparty"
require "json"
require "googl"
require "rest-client"
require "open-uri"
require "mediawiki-butt"
require "lyricfy"
require "highline"
require "nokogiri"
require "voice"
require "require_all"

require_relative "utility"
require_relative "esaebsadcommand"
require_rel "plugins"

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.esper.net"
    c.channels = ["#NuclearControl2", "#FTB-Wiki", "#FTB-Wiki-Dev"]
    c.nick = ESAEBSAD::Utility::BOT_NAME
    c.plugins.plugins = ESAEBSADCommand.get_subclasses
  end
end

bot.start
