class Quote < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  match "quote"
  def execute(msg)
    msg.reply(get_data("quote").sample)
  end
end
