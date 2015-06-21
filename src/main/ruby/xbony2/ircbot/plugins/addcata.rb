class Addcata
  include Cinch::Plugin
  
  set :prefix, /^@@/
  match /addcata (.*); (.*); (.*)/
  def execute(msg, sub1, sub2, name)
    if m.user.authname != $OWNER_NAME
      m.reply "You are not authorized."
      return
    elsif sub2 != "nil"
      $wiki_bot.create_page("Category:#{name}", "[[Category:#{sub1}]]\n[[Category:#{sub2}]]")
    else
        $wiki_bot.create_page("Category:#{name}", "[[Category:#{sub1}]]")
    end
    m.reply "Here you go: http://ftb.gamepedia.com/Category:#{name.gsub(' ', '_')}"
  end
end
