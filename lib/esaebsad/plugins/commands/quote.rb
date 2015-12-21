require_relative "../../variables"

class Quote < ESAEBSADCommand
  include Cinch::Plugin

  Variables.set_help "quote", <<EOS
Group: all. Syntax: "@@quote"
The quote command will yield a clean, motivating quote.
EOS
  set :prefix, /^@@/
  match "quote"
  def execute(msg)
    msg.reply ["\"FUCK YOU!\" - bitch-ass kid", "I luff yew baby <3 Have my wixi babies", "wikislaves aren't suppose to die", "You're the great and powerful trixie?",
      "*enjoys the sensation of PrincessTwilightSparkle burping on his ass*", "Quick xbrony, dash! rainbow dash !",  "\"My cat is bullying me. How do I fight him?\"",
      "All a girl wants is to be treated rough, god.", "[[What is love]]",  "Hydra can go [CENSORED] itself", "them ghasts have such wide holes ;)", "you must eat it so your cat isn't insulted",
      "IMMA INSERT MY EXTRA PENISES IN YOUR EARHOLES NOW", "NONE OF MY HOLES ARE SAFE", "EVERYTHING BUT THE BUTT", "My butt is nice tyvm",
      "I dream of being thrown around by a fry pan, dropping hot sticky loads of egg yolk on people", "we need more wiki-slaves",  "yer a scrub", "hey bby, wanna fck?",
      "When I first discovered masturbation at Catholic school, I was terrified - I thought I was broken.", "i got the movvvvvvvieesss like jagaaaaar",
      "I couldn't understand why jizz was coming out of my cock instead of my arsehole like it normally did.", "You didn't state how enthuseastically you licked, or where you licked",
      "an \"Advanced Lubrication System\" sounds like it would be something very fun to use :3", "WHAT IS LOVE / BABY DON'T HURT ME", "\"I am the oracle.\"",
      "Just get to the point where you and peter end up having sex over the desk, and the librarian comes across and beats you with a meter long ruler?", "wut",
      "Peter likes his literotica", "DONT RAPE ME PETER", "Aint rape if you enjoy it", "I squirm, and peter squirms inside me.", "And he bites me inappropriately, while I screech.",
      "I know he enjoys this. And deep down, I do to.", "So much pain… but so much pleasure.", "you know I like it solid :3",
      "\"What's a girls?\" - \"Some place you where pulled out from and you desperately want to go into?\"", "ALL YOUR HOLES ARE BELONG TO US", "fuck hydra",
      "Life's not a bitch, life is a beautiful woman / You only call her a bitch 'cause she won't let you get that pussy", "\"Be safe, be kind, be generious: Use a condom!"].sample
  end
end
