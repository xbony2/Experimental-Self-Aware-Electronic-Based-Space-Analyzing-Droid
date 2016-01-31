class ReplaceAllInCategory < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  create_help "replaceallincategory", <<EOS
Group: op. Syntax: "@@replaceallincategory [wiki]; (cat); (oldtext); (newtext)"
The replace all in category command will convert all instanences of text in a category to a new text.
EOS
  set :prefix, /^@@/
  match /replaceallincategory (.*); (.*); (.+|.?)/, method: :default
  match /replaceallincategory (.+); (.*); (.*); (.+|.?)/, method: :execute
  
  def default(msg, cat, oldtext, newtext)
    execute(msg, WIKI_CORE, cat, oldtext, newtext)
  end
  
  def execute(msg, wiki, cat, oldtext, newtext)
    if is_op? msg.user.authname, wiki
      client = get_client(wiki)
      client.get_category_members("Category:#{cat}").each do |page|
        text = client.get_text(page)
        client.edit(page, text.gsub(irc_escape(oldtext), irc_escape(newtext))) if text.include?(irc_escape(oldtext))
      end
      msg.reply "Process complete."
    else
      msg.reply "You are not authorized."
    end
  end
end
