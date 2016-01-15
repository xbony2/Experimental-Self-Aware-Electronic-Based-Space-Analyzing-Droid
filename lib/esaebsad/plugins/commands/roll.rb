class Roll < ESAEBSADCommand
  include Cinch::Plugin

  set_help "roll", <<EOS
Group: all. Syntax: "@@roll"
The roll command rolls a die.
EOS
  set :prefix, /^@@/
  match "roll"
  def execute(msg)
    msg.reply "The die roll reveals the number #{1 + rand(6)}."
  end
end
