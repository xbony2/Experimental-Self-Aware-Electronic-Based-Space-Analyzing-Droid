class ReplaceAllInCategory < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  create_help "replaceallincategory"
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
