class Roll < ESAEBSADCommand
  include Cinch::Plugin
    
  set :prefix, /^@@/
  match "roll"
  def execute(msg)
    msg.reply "The die roll reveals the number #{1 + rand(6)}."
  end
end
