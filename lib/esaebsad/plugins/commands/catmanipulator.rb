class CatManipulator < ESAEBSADCommand
  include Cinch::Plugin
  
  set_help("cat_manipulate", "Group: owner. Syntax: \"@@cat_manipulate (cat); (newcat); (wiki)\"\nThe cat manipulate command will convert all instanences of a category to a different category.")
  set :prefix, /^@@/
  match /cat_manipulate (.*); (.*); (.+)/
  def execute(msg, cat, newcat, wiki)
    if msg.user.authname != $OWNER_NAME
      msg.reply "You are not authorized."
    else
      category = wiki == "br" ? "Categoria" : "Category"
      
      newcat = newcat == "nil" ? "" : "[[#{category}:#{newcat}]]"
      get_client(wiki).get_category_members("Category:#{cat}").each do |page|
        get_client.edit(page, get_client.get_text(page).gsub(/\[\[(Category|Categoria):#{cat}\]\]/, newcat), summary: "Modified category. | Modificado categoria.")
      end
      msg.reply "Process complete."
    end
  end
end