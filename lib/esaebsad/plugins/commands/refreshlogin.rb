class RefreshLogin < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  match "refreshlogin"
  def execute(msg)
    CLIENTS.each do |wiki, obj|
      obj.logout
    end
    
    CLIENTS.each do |wiki, obj|
      obj.login(WIKI_BOT_NAME, CONFIG["wiki"]["password"])
    end
    
    msg.reply(localize("command.shared.complete"))
  end
end
