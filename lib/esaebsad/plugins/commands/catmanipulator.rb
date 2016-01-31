class CatManipulator < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  create_help "catmanipulate"
  set :prefix, /^@@/
  match /catmanipulate (.*); (.*); (.+)/
  def execute(msg, cat, newcat, wiki)
    if is_part_of_group? msg.user.authname, "owner"
      category = wiki == "minecraftbr" ? "Categoria" : "Category"

      newcat = newcat == "nil" ? "" : "[[#{category}:#{newcat}]]"
      get_client(wiki).get_category_members("Category:#{cat}").each do |page|
        get_client.edit(page, get_client.get_text(page).gsub(/\[\[(Category|Categoria):#{cat}\]\]/, newcat), summary: "Modified category. | Modificado categoria.")
      end
      msg.reply "Process complete."
    else
      msg.reply "You are not authorized."
    end
  end
end
