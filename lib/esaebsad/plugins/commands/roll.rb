class Roll < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  create_help "roll"
  set :prefix, /^@@/
  match "roll"
  def execute(msg)
    msg.reply(localize("command.roll", 1 + rand(6)))
  end
end
