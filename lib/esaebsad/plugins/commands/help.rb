class Help < ESAEBSADCommand
  include Cinch::Plugin
  
  set_help("help", "Group: all. Syntax: \"@@help [command]\"\nThe help command gives a list of commands.\nWhen supplied with a parameter, it will give information specific to that command.")
  set :prefix, /^@@/
  match "help", method: :list
  match /help (.+)/, method: :advanced
  
  def list(msg)
    msg.reply "List of commands: #{$help_commands.keys.join(', ')}"
  end
  
  def advanced(msg, command)
    msg.reply($help_commands.keys.include?(command) ? $help_commands[command] : "Command not found.")
  end
end
