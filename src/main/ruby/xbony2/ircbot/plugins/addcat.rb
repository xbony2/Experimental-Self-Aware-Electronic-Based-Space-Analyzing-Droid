class Addcat
  include Cinch::Plugin
    
  set :prefix, /^@@/
  match /addcat (.+); (.*)/
  def execute(msg, type, name)
    if msg.user.authname != $OWNER_NAME
      msg.reply "You are not authorized."
    else
      if type == "mod"
        $butt.edit("Category:#{name}", "[[Category:Mod categories]]\n[[Category:Mods]]", "Created category page.")
      elsif type == "minor"
        $butt.edit("Category:#{name}", "[[Category:Mod categories]]\n[[Category:Minor Mods]]", "Created category page.")
      else
        msg.reply "You screwed up. Try again."
        return
      end
      msg.reply "Here you go: http://ftb.gamepedia.com/Category:#{name.gsub(' ', '_')}"
     end
  end
end