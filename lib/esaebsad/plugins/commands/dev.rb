class Dev < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  create_help "dev", <<EOS
Group: all. Syntax: "@@dev"
The dev command gives basic information on ESAEBSAD.
EOS
  set :prefix, /^@@/
  match "dev"
  def execute(msg)
    msg.reply "I am an IRC/wiki bot created by Xbony2 in Ruby, using the cinch and MW Butt gems."
    msg.reply "I am open-sourced and under the MIT license: http://goo.gl/GkH1x1"
  end
end
