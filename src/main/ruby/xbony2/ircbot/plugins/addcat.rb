class Addcat
  include Cinch::Plugin
    
  set :prefix, /^@@/
  match /addcat (.+); (.*)/
  def execute(msg, type, name)
    if msg.user.authname != $OWNER_NAME
      msg.reply "You are not authorized."
    else
      if type == "mod"
        $wiki_bot.edit(title: "Category:#{name}", text: "[[Category:Mod categories]]\n[[Category:Mods]]", bot: 1)
      elsif type == "minor"
        $wiki_bot.edit(title: "Category:#{name}", text: "[[Category:Mod categories]]\n[[Category:Minor Mods]]", bot: 1)
      else
        msg.reply "You screwed up. Try again."
        return
      end
      msg.reply "Here you go: http://ftb.gamepedia.com/Category:#{name.gsub(' ', '_')}"
     end
  end
end