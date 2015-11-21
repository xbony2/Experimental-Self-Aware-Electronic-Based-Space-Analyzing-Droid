class GamepediaDump < ESAEBSADCommand
  include Cinch::Plugin
  
  set :prefix, /^@@/
  match "gamepediadump"
  def execute(msg)
    if is_part_of_group? msg.user.authname, :owner
      file = File.new("domains.txt", "w")
      file.puts `python /Users/xbony2/Downloads/subbrute/subbrute.py gamepedia.com`
      file.close
    else
      msg.reply "You are not authorized."
    end
  end
end
