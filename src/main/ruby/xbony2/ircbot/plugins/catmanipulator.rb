class Catmanipulator
  include Cinch::Plugin
  
  set :prefix, /^@@/
  match /catmanipulate (.*); (.*)/
  def execute(msg, cat, newcat)
    if msg.user.authname != $OWNER_NAME
      msg.reply "You are not authorized."
    else
      newcat = newcat == "nil" ? "" : "[[Category:#{newcat}]]"
      $butt.get_category_members("Category:#{cat}").each do |page| 
        $butt.edit(page, $butt.get_text(page).gsub(/\[\[Category:#{cat}\]\]/, newcat), "Modified category.")
      end
      msg.reply "Process complete."
    end
  end
end