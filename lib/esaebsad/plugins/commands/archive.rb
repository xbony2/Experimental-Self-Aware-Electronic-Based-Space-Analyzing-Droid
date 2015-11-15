class Archive < ESAEBSADCommand
  include Cinch::Plugin
  
  set_help("archive", "Group: all. Syntax: \"@@archive (url)\"\nThe archive shorten command will backup a url using the Internet Archieve (archive.com).")
  set :prefix, /^@@/
  match /archive (.+)/
  def execute(msg, url)
    open "http://web.archive.org/save/#{url}"
    msg.reply "Will be available here shortly: https://web.archive.org/web/*/#{url}"
  end
end
