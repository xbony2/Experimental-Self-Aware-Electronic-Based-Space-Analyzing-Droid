class UrlShorten < ESAEBSADCommand
  include Cinch::Plugin
  
  set_help("url_shorten", "Group: all. Syntax: \"@@url_shorten (url)\"\nThe url shorten command will shorten a url using Goo.gl.")
  set :prefix, /^@@/
  match /url_shorten (.+)/
  def execute(msg, url)
    msg.reply "New URL: #{Googl.shorten(url).short_url}"
  end
end
