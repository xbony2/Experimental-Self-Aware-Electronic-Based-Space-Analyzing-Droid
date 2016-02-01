class UrlShorten < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  match /urlshorten (.+)/
  def execute(msg, url)
    msg.reply(localize("command.urlshorten", Googl.shorten(url).short_url))
  end
end
