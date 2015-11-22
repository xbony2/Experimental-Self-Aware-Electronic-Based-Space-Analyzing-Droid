class Help < ESAEBSADCommand
  include Cinch::Plugin
  
  set_help "help", <<EOS
Group: all. Syntax: "@@help [command]"
The help command gives a list of commands.
When supplied with a parameter, it will give information specific to that command.
EOS
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
