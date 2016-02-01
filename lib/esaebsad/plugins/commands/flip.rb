class Flip < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  match "flip"
  def execute(msg)
    msg.reply(localize("command.flip.result", rand(2) == 0 ? localize("command.flip.heads") : localize("command.flip.tails")))
  end
end
