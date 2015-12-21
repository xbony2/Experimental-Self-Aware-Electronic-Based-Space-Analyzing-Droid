require_relative "../../variables"

class Flip < ESAEBSADCommand
  include Cinch::Plugin

  Variables.set_help "flip", <<EOS
Group: all. Syntax: "@@flip"
The flip command flips a coin.
EOS
  set :prefix, /^@@/
  match "flip"
  def execute(msg)
    msg.reply "The coin flip reveals #{rand(2) == 0 ? "heads" : "tails"}."
  end
end
