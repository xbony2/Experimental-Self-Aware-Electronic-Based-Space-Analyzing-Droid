class AddCatt < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility
  
  match /addcatt (.+); (.*)/
  def execute(msg, type, name)
    if is_part_of_group? msg.user.authname, "ftbop"
      case type
      when "mod" then get_client.create_page("Category:#{name}", "[[Category:Mod categories]]\n[[Category:Mods]]", "Created category page.")
      when "minor" then get_client.create_page("Category:#{name}", "[[Category:Mod categories]]\n[[Category:Minor Mods]]", "Created category page.")
      else
        msg.reply(localize("command.shared.mistake"))
        return
      end

      msg.reply(localize("command.shared.link", "http://ftb.gamepedia.com/Category:#{urlize(name)}"))
    else
      msg.reply(localize("command.shared.unauthorized"))
    end
  end
end
