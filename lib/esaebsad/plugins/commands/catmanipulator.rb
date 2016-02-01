class CatManipulator < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  match /catmanipulate (.*); (.*); (.+)/
  def execute(msg, cat, newcat, wiki)
    if is_part_of_group? msg.user.authname, "owner"
      category = localize("mw.category")

      newcat = newcat == "nil" ? "" : "[[#{category}:#{newcat}]]"
      get_client(wiki).get_category_members("Category:#{cat}").each do |page|
        get_client.edit(page, get_client.get_text(page).gsub(/\[\[#{localize("mw.category")}:#{cat}\]\]/, newcat), localize("mw.summary.modifiedcat"))
      end
      msg.reply(localize("command.shared.complete"))
    else
      msg.reply(localize("command.shared.unauthorized"))
    end
  end
end
