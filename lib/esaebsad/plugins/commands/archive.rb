class Archive < ESAEBSADCommand
  include Cinch::Plugin
    
  set :prefix, /^@@/
  match /archive (.+)/
  def execute(msg, site)
    open "http://web.archive.org/save/#{site}"
    msg.reply "Will be available here shortly: https://web.archive.org/web/*/#{site}"
  end
end
