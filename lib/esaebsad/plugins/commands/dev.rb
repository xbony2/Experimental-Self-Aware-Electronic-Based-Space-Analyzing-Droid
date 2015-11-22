class Dev < ESAEBSADCommand
  include Cinch::Plugin
  
  set_help "dev", <<EOS
Group: all. Syntax: "@@dev"
The dev command gives basic information on ESAEBSAD.
EOS
  set :prefix, /^@@/
  match "dev"
  def execute(msg)
    msg.reply "I am an IRC bot created by Xbony2 in Ruby, using the cinch gem."
    msg.reply "I am open-sourced and under the MIT license: http://goo.gl/GkH1x1"
  end
end
