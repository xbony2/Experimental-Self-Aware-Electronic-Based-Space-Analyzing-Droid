class ReplaceAllInCategory < ESAEBSADCommand
  include Cinch::Plugin
  
  set_help("replaceallincategory", "Group: owner. Syntax: \"@@replaceallincategory (cat); (oldtext); (newtext)\"\nThe replaceallincategory command will convert all instanences of text is a category to a new text.")
  set :prefix, /^@@/
  match /replaceallincategory (.*); (.*); (.+|.?)/
  def execute(msg, cat, oldtext, newtext)
    if msg.user.authname != $OWNER_NAME
      msg.reply "You are not authorized."
    else
      get_client.get_category_members("Category:#{cat}").each do |page|
        text = get_client.get_text(page)
        get_client.edit(page, text.gsub(oldtext, newtext), summary: "Converting \"#{oldtext}\" to \"#{newtext}\"") if text.include?(oldtext)
      end
      msg.reply "Process complete."
    end
  end
end
