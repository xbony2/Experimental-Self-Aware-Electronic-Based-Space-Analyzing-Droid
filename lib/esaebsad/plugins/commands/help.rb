class Help < ESAEBSADCommand
  include Cinch::Plugin
  
  set :prefix, /^@@/
  match "help"
  def execute(msg)
    msg.reply "Commands: @@help, @@flip, @@roll, @@dev, @@motivate, @@url-shorten @@quote, @@flirt, @@articleofthweek, @@info and @@archive."
    msg.reply "Owner only commands: @@stop, @@lyrics, @@addcat, @@addcata, @@say, @@catmanipulate, @@replaceallincategory and @@trans."
  end
end
