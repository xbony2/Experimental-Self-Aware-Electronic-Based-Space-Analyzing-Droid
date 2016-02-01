class Motivate < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  match "motivate"
  def execute(msg)
    msg.reply(get_data("motivate").sample)
  end
end
