class CatManipulator
  include Cinch::Plugin
  
  set :prefix, /^@@/
  match /catmanipulate (.*); (.*);? ?(.+)/
  def execute(msg, cat, newcat, wiki)
    if msg.user.authname != $OWNER_NAME
      msg.reply "You are not authorized."
    else
      client = wiki == "br" ? $br_client : $ftb_client
      
      newcat = newcat == "nil" ? "" : "[[Category:#{newcat}]]"
      client.get_category_members("Category:#{cat}").each do |page| 
        client.edit(page, client.get_text(page).gsub(/\[\[Category:#{cat}\]\]/, newcat), "Modified category.")
        client.edit(page, client.get_text(page).gsub(/\[\[Categoria:#{cat}\]\]/, newcat), "Modified category. | Modificado categoria.")
      end
      msg.reply "Process complete."
    end
  end
end