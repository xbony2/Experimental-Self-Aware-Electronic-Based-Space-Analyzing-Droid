class CatManipulator
  include Cinch::Plugin
  
  set :prefix, /^@@/
  match /catmanipulate (.*); (.*);? ?(.+)/
  def execute(msg, cat, newcat, wiki)
    if msg.user.authname != $OWNER_NAME
      msg.reply "You are not authorized."
    else
      client = wiki == "br" ? $br_client : $ftb_client
      category = wiki == "br" ? "Categoria" : "Category"
      
      newcat = newcat == "nil" ? "" : "[[#{category}:#{newcat}]]"
      client.get_category_members("Category:#{cat}").each do |page|
        msg.reply "Page found: #{page}"
        client.edit(page, client.get_text(page).gsub(/\[\[#{category}:#{cat}\]\]/, newcat), "Modified category. | Modificado categoria.")
      end
      msg.reply "Process complete."
    end
  end
end