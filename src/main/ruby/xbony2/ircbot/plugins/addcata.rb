class Addcata
  include Cinch::Plugin
  
  set :prefix, /^@@/
  match /addcata (.*); (.*); (.*)/
  def execute(msg, sub1, sub2, name)
    if msg.user.authname != $OWNER_NAME
      msg.reply "You are not authorized."
      return
    elsif sub2 != "nil"
      $wiki_bot.edit(title: "Category:#{name}", text: "[[Category:#{sub1}]]\n[[Category:#{sub2}]]", bot: 1)
    else
      $wiki_bot.edit(title: "Category:#{name}", text: "[[Category:#{sub1}]]", bot: 1)
    end
    msg.reply "Here you go: http://ftb.gamepedia.com/Category:#{name.gsub(' ', '_')}"
  end
end
