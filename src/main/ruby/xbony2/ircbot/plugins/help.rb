class Help
  include Cinch::Plugin
  
  set :prefix, /^@@/
  match "help"
  def execute(msg)
    msg.reply "Commands: @@help, @@flip, @@roll, @@dev, @@motivate, @@url-shorten @@quote, @@flirt, and @@archive."
    msg.reply "Owner only commands: @@stop, @@lyrics, @@addcat, @@addcata, @@say, and @@trans."
  end
end
