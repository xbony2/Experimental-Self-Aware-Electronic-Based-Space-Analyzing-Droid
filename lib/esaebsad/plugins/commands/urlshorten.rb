class UrlShorten < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  create_help "urlshorten"
  set :prefix, /^@@/
  match /urlshorten (.+)/
  def execute(msg, url)
    msg.reply(localize("command.urlshorten.message", Googl.shorten(url).short_url))
  end
end
