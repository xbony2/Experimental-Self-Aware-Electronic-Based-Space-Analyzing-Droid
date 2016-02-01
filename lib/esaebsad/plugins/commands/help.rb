class Help < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  match "help", method: :list
  match /help (.+)/, method: :advanced

  def list(msg)
    help_commands = []
    LANGUAGE_STRINGS.each_key do |key|
      help_commands << key.sub(/help\./, "") if key.start_with?("help.")
    end
    
    msg.reply(localize("command.help.list", help_commands.join(localize("command.help.seperater"))))
  end

  def advanced(msg, command)
    begin
      help = LANGUAGE_STRINGS["help.#{command}"].join("\n").gsub(/\$P/, IRC_PREFIX)
      msg.reply(help)
    rescue NoMethodError
      msg.reply(localize("command.help.notfound"))
    end
  end
end
