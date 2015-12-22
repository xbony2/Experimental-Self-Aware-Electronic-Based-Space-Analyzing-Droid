require_relative "../../variables"

class Stop < ESAEBSADCommand
  include Cinch::Plugin

  Variables.set_help "stop", <<EOS
Group: owner. Syntax: "@@stop"
The stop command will stop ESAEBSAD.
EOS
  set :prefix, /^@@/
  match "stop"
  def execute(msg)
    is_part_of_group?(msg.user.authname, :owner) ? exit : msg.reply("You cannot stop me unless you're my creator.")
  end
end
