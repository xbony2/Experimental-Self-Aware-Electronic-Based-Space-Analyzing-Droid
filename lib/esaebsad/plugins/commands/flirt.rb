class Flirt < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  create_help "flirt"
  set :prefix, /^@@/
  match /flirt (.+)/
  def execute(msg, flirtery) # For lack of a better term
    msg.reply(localize("command.flirt.message").sub(/&1/, flirtery).sub(/&2/, get_data("flirt").sample.sub(/#MSGNICK/, msg.user.nick)))
  end
end
