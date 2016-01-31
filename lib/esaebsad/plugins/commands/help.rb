class Help < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  create_help "help"
  set :prefix, /^@@/
  match "help", method: :list
  match /help (.+)/, method: :advanced

  def list(msg)
    msg.reply(localize("command.help.list"), HELP_COMMANDS.keys.join(localize("command.help.seperater")))
  end

  def advanced(msg, command)
    help = HELP_COMMANDS
    msg.reply(help.include?(command) ? help[command] : localize("command.help.notfound"))
  end
end
