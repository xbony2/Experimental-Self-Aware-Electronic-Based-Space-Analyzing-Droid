class Flip < ESAEBSADCommand
  include Cinch::Plugin
    
  set :prefix, /^@@/
  match "flip"
  def execute(msg)
    msg.reply "The coin flip reveals #{1 + rand(2) == 1? "heads" : "tails"}."
  end
end
