class ReplaceAllInCategory < ESAEBSADCommand
  include Cinch::Plugin
  
  set_help "replace_all_in_category", <<EOS
Group: owner. Syntax: "@@replace_all_in_category (cat); (oldtext); (newtext)"
The replace all in category command will convert all instanences of text is a category to a new text.
EOS
  set :prefix, /^@@/
  match /replaceallincategory (.*); (.*); (.+|.?)/
  def execute(msg, cat, oldtext, newtext)
    if is_part_of_group? msg.user.authname, :owner
      get_client.get_category_members("Category:#{cat}").each do |page|
        text = get_client.get_text(page)
        get_client.edit(page, text.gsub(oldtext, newtext), summary: "Converting \"#{oldtext}\" to \"#{newtext}\"") if text.include?(oldtext)
      end
      msg.reply "Process complete."
    else
      msg.reply "You are not authorized."
    end
  end
end
