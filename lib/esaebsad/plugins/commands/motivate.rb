class Motivate < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  create_help "motivate", <<EOS
Group: all. Syntax: "@@motivate"
The motivate command will yield a motivating message.
EOS
  set :prefix, /^@@/
  match "motivate"
  def execute(msg)
    msg.reply(get_data("motivate").sample)
  end
end
