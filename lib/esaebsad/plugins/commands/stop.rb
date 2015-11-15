class Stop < ESAEBSADCommand
  include Cinch::Plugin
  
  set_help("stop", "Group: owner. Syntax: \"@@stop\"\nThe stop command will stop ESAEBSAD.")
  set :prefix, /^@@/
  match "stop"
  def execute(msg)
    is_part_of_group? msg.user.authname, :owner ? exit : msg.reply("You cannot stop me unless you're my creator.")
  end
end
