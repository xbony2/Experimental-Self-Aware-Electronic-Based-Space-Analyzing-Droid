class Flip < ESAEBSADCommand
  include Cinch::Plugin
  
  set_help("flip", "Group: all. Syntax: \"@@flip\"\nThe flip command flips a coin.")
  set :prefix, /^@@/
  match "flip"
  def execute(msg)
    msg.reply "The coin flip reveals #{rand(2) == 0 ? "heads" : "tails"}."
  end
end
