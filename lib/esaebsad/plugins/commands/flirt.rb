class Flirt < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  match /flirt (.+)/
  def execute(msg, flirtery) # For lack of a better term
    msg.reply(localize("command.flirt", flirtery, get_data("flirt").sample.sub(/#MSGNICK/, msg.user.nick)))
  end
end
