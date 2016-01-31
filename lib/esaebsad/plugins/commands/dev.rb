class Dev < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  create_help "dev"
  set :prefix, /^@@/
  match "dev"
  def execute(msg)
    msg.reply(localize("command.dev.1"))
    msg.reply(localize("command.dev.2"))
  end
end
