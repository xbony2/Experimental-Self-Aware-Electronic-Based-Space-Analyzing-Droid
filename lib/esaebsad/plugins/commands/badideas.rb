class BadIdeas < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility
  
  create_help "badideas"
  set :prefix, /^@@/
  match "badideas"
  def execute(msg)
    msg.reply(get_data("badideas").sample)
  end
end