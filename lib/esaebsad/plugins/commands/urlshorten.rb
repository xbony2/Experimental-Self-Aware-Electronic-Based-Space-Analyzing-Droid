class UrlShorten < ESAEBSADCommand
  include Cinch::Plugin
    
  set :prefix, /^@@/
  match /url-shorten (.+)/
  def execute(msg, url)
    msg.reply "New URL: #{Googl.shorten(url).short_url}"
  end
end
