class Dev < ESAEBSADCommand
  include Cinch::Plugin
  
  set_help("dev", "Group: all. Syntax: \"@@dev\"\nThe dev command gives basic information on ESAEBSAD.")
  set :prefix, /^@@/
  match "dev"
  def execute(msg)
    msg.reply "I am an IRC bot created by Xbony2 in Ruby, using the cinch gem."
    msg.reply "I am open-sourced and under the MIT license: http://goo.gl/GkH1x1"
  end
end
