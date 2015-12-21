require_relative '../../variables'

class Flirt < ESAEBSADCommand
  include Cinch::Plugin

  Variables.set_help "flirt", <<EOS
Group: all. Syntax: "@@flirt (flirtery)"
The flirt command will make ESAEBSAD flirt with the "flirtery".
EOS
  set :prefix, /^@@/
  match /flirt (.+)/
  def execute(msg, flirtery) #For lack of a better term
    msg.reply "#{flirtery}: hey bby, #{["wanna fuck?", "you must be a portal, cause' I want you to explore my nether dimension.",
    "you must be an infinite array, cause I want to interate in your forever.", "I wanna riddlyriddly-do all over you ( ͡° ͜ʖ ͡°)",
    "I'm comein' to your house to eat your pizza, and then to eat you ( ͡° ͜ʖ ͡°)", "you’re on my list of thing to do :3", "you make me as hard as a ruby :3 wait...",
    "let me fill you up like #{msg.user.nick} filled my parameters up ( ͡° ͜ʖ ͡°)", "get out the ropes and bend the fuck over right now >:D"].sample}"
  end
end
