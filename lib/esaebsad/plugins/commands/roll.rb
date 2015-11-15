class Roll < ESAEBSADCommand
  include Cinch::Plugin
  
  set_help("roll", "Group: all. Syntax: \"@@roll\"\nThe roll command rolls a die.")
  set :prefix, /^@@/
  match "roll"
  def execute(msg)
    msg.reply "The die roll reveals the number #{1 + rand(6)}."
  end
end
