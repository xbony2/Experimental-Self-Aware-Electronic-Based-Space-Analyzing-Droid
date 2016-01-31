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
require "require_all"
require "yaml"

require_relative "utility"
require_relative "esaebsadcommand"
require_rel "plugins"

bot = Cinch::Bot.new do
  configure do |c|
    c.server = ESAEBSAD::Utility::IRC_SERVER
    c.channels = ESAEBSAD::Utility::IRC_CHANNELS
    c.nick = ESAEBSAD::Utility::IRC_BOT_NAME
    c.plugins.plugins = ESAEBSADCommand.get_subclasses
  end
end

bot.start
