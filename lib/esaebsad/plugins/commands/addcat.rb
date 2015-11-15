class AddCat < ESAEBSADCommand
  include Cinch::Plugin
  
  set_help("add_cat", "Group: owner. Syntax: \"@@add_cat (type); (name)\"\nThe addcat command will create a new category based on the type.\nExample: \"@@add_cat mod; Thermal Expansion 3\".")
  set :prefix, /^@@/
  match /add_cat (.+); (.*)/
  def execute(msg, type, name)
    if msg.user.authname != $OWNER_NAME
      msg.reply "You are not authorized."
    else
      case type
      when "mod" then get_client.create_page("Category:#{name}", "[[Category:Mod categories]]\n[[Category:Mods]]", "Created category page.")
      when "minor" then get_client.create_page("Category:#{name}", "[[Category:Mod categories]]\n[[Category:Minor Mods]]", "Created category page.")
      else
        msg.reply "You screwed up. Try again."
        return
      end
      
      msg.reply "Here you go: http://ftb.gamepedia.com/Category:#{urlize(name)}"
     end
  end
end