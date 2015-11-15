class Stop < ESAEBSADCommand
  include Cinch::Plugin
  
  set_help("stop", "Group: owner. Syntax: \"@@stop\"\nThe stop command will stop ESAEBSAD.")
  set :prefix, /^@@/
  match "stop"
  def execute(msg)
    if msg.user.authname == $OWNER_NAME
      exit
    else
      msg.reply "You cannot stop me unless you're my creator."
    end
  end
end
