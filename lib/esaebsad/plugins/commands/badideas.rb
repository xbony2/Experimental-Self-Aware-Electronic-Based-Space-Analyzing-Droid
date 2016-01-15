class BadIdeas < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  
  set_help "badideas", <<EOS
Group: all. Syntax: "@@badideas"
The bad ideas command will yield a bad idea.
EOS
  set :prefix, /^@@/
  match "badideas"
  def execute(msg)
    msg.reply(get_data("badideas").sample)
  end
end