class ReplaceAllInCategory < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  create_help "replaceallincategory", <<EOS
Group: ftbop. Syntax: "@@replaceallincategory (cat); (oldtext); (newtext)"
The replace all in category command will convert all instanences of text in a category to a new text.
EOS
  set :prefix, /^@@/
  match /replaceallincategory (.*); (.*); (.+|.?)/
  def execute(msg, cat, oldtext, newtext)
    if is_part_of_group? msg.user.authname, "ftbop"
      get_client.get_category_members("Category:#{cat}").each do |page|
        text = get_client.get_text(page)
        get_client.edit(page, text.gsub(irc_escape(oldtext), irc_escape(newtext))) if text.include?(irc_escape(oldtext))
      end
      msg.reply "Process complete."
    else
      msg.reply "You are not authorized."
    end
  end
end
