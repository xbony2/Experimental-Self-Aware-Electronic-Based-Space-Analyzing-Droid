class Flirt < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  create_help "flirt", <<EOS
Group: all. Syntax: "@@flirt (flirtery)"
The flirt command will make ESAEBSAD flirt with the "flirtery".
EOS
  set :prefix, /^@@/
  match /flirt (.+)/
  def execute(msg, flirtery) # For lack of a better term
    msg.reply "#{flirtery}: hey bby, #{get_data("flirt").sample.gsub(/#MSGNICK/, msg.user.nick)}"
  end
end
