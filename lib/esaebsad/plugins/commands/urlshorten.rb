class UrlShorten < ESAEBSADCommand
  include Cinch::Plugin
  
  set_help("url-shorten", "Group: all. Syntax: \"@@url-shorten (url)\"\nThe url shorten command will shorten a url using Goo.gl.")
  set :prefix, /^@@/
  match /url-shorten (.+)/
  def execute(msg, url)
    msg.reply "New URL: #{Googl.shorten(url).short_url}"
  end
end
