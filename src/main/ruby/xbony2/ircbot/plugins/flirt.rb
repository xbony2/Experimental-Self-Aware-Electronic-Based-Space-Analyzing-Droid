class Flirt
  include Cinch::Plugin
    
  set :prefix, /^@@/
  match "flirt"
  def execute(msg)
    msg.reply "#{["LittleHelper", "MineBot", "PrincessCelestia", "Alfred"].sample}: hey bby, wanna fuck?"
  end
end