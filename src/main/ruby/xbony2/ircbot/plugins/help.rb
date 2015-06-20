class Help
  include Cinch::Plugin
  
  match /^@@help/ #TODO: broken
  def execute(msg)
    msg.reply "Commands: @@help, @@flip, @@roll, @@dev, @@motivate, @@url-shorten and @@archive."
    msg.reply "Owner only commands: @@stop, @@upload, @@lyrics, @@addcat, @@addcata, and @@trans."
  end
end
