require_relative "../../variables"

class CatManipulator < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility

  Variables.set_help "catmanipulate", <<EOS
Group: owner. Syntax: "@@catmanipulate (cat); (newcat); (wiki)"
The cat manipulate command will convert all instanences of a category to a different category.
EOS
  set :prefix, /^@@/
  match /catmanipulate (.*); (.*); (.+)/
  def execute(msg, cat, newcat, wiki)
    if is_part_of_group? msg.user.authname, :owner
      category = wiki == "br" ? "Categoria" : "Category"

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
