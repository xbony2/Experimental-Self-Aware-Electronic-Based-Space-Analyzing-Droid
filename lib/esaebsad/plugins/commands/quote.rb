class Quote < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  create_help "quote", <<EOS
Group: all. Syntax: "@@quote"
The quote command will yield a clean, motivating quote.
EOS
  set :prefix, /^@@/
  match "quote"
  def execute(msg)
    msg.reply(get_data("quote").sample)
  end
end
