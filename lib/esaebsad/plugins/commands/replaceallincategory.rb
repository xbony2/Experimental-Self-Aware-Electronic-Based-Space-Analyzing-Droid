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
      oldtext = irc_escape(oldtext)
      newtext = irc_escape(newtext)
      
      client.get_category_members("#{localize("mw.category")}:#{cat}").each do |page|
        text = client.get_text(page)
        client.edit(page, text.gsub(oldtext, newtext), summary: localize("mw.summary.replaceallincat", oldtext, newtext, cat)) if text.include?(irc_escape(oldtext))
      end
      msg.reply(localize("command.shared.complete"))
    else
      msg.reply(localize("command.shared.unauthorized"))
    end
  end
end
