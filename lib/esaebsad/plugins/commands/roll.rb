class Roll < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  match "roll"
  def execute(msg)
    msg.reply(localize("command.roll", 1 + rand(6)))
  end
end
