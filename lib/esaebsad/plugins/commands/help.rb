class Help < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility

  set_help "help", <<EOS
Group: all. Syntax: "@@help [command]"
The help command gives a list of commands.
When supplied with a parameter, it will give information specific to that command.
EOS
  set :prefix, /^@@/
  match "help", method: :list
  match /help (.+)/, method: :advanced

  def list(msg)
    commands = get_help_commands.keys.join(", ")
    msg.reply "List of commands: #{commands}"
  end

  def advanced(msg, command)
    help = get_help
    message = help.include?(command) ? help[command] : "Command not found."
    msg.reply(message)
  end
end
