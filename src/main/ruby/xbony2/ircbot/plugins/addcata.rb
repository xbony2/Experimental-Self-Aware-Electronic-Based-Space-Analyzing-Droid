class Addcata
  include Cinch::Plugin
  
  set :prefix, /^@@/
  match /addcata (.*); (.*); (.*)/
  def execute(msg, sub1, sub2, name)
    if msg.user.authname != $OWNER_NAME
      msg.reply "You are not authorized."
      return
    elsif sub2 != "nil"
      $butt.edit("Category:#{name}", "[[Category:#{sub1}]]\n[[Category:#{sub2}]]", "Created category page.")
    else
      $butt.edit("Category:#{name}", "[[Category:#{sub1}]]", "Created category page.")
    end
    msg.reply "Here you go: http://ftb.gamepedia.com/Category:#{name.gsub(' ', '_')}"
  end
end
