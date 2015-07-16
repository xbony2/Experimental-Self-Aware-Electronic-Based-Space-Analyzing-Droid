class Flirt
  include Cinch::Plugin
    
  set :prefix, /^@@/
  match "flirt"
  def execute(msg)
    fellow_bot = ["LittleHelper", "MineBot", "PrincessCelestia", "Alfred", "Haylee"].sample
    puts fellow_bot
    msg.reply(Cinch::User.new(fellow_bot).online? ? "#{fellow_bot}: hey bby, wanna fuck?": "#{msg.user.nick}: fuck you")
  end
end