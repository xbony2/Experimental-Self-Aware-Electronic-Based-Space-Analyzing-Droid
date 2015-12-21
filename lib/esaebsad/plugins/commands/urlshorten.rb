require_relative "../../variables"

class UrlShorten < ESAEBSADCommand
  include Cinch::Plugin

  Variables.set_help "urlshorten", <<EOS
Group: all. Syntax: "@@urlshorten (url)"
The url shorten command will shorten a url using Goo.gl.
EOS
  set :prefix, /^@@/
  match /urlshorten (.+)/
  def execute(msg, url)
    msg.reply "New URL: #{Googl.shorten(url).short_url}"
  end
end
