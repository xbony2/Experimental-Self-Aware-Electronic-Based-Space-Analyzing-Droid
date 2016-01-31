class Flip < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  create_help "flip"
  set :prefix, /^@@/
  match "flip"
  def execute(msg)
    msg.reply "The coin flip reveals #{rand(2) == 0 ? "heads" : "tails"}."
  end
end
