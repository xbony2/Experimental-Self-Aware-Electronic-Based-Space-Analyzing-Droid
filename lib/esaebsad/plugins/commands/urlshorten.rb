class UrlShorten < ESAEBSADCommand
  include Cinch::Plugin
  
  set_help "url_shorten", <<EOS
Group: all. Syntax: "@@url_shorten (url)"
The url shorten command will shorten a url using Goo.gl.
EOS
  set :prefix, /^@@/
  match /url_shorten (.+)/
  def execute(msg, url)
    msg.reply "New URL: #{Googl.shorten(url).short_url}"
  end
end
