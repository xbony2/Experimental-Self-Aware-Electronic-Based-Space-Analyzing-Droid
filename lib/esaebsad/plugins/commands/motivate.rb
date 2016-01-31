class Motivate < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  create_help "motivate"
  set :prefix, /^@@/
  match "motivate"
  def execute(msg)
    msg.reply(get_data("motivate").sample)
  end
end
