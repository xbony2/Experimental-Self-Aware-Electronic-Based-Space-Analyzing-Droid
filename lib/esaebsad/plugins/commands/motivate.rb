class Motivate < ESAEBSADCommand
  include Cinch::Plugin
    
  set :prefix, /^@@/
  match "motivate"
  def execute(msg)
    msg.reply ["I love you the way you are.", "You are doing great.", "You're awesome",  "ERROR: so awesome I don't know what to do.", "I want you.", "I would let you eat my butthole.", 
    "I am unworthy of you eating my butthole.",  "Fuck that, what about me?", "You're awesome, that's just it.", "Your so awesome I forgot to grammar.", "You're almost as cool as Xbony2.",
    "I'm going to touch you when you aren't looking.", "Give yourself a pat on the back.",  "It is a good day when you are here.", "You are my savior", "SatanicSanta is smelly"].sample
  end
end
