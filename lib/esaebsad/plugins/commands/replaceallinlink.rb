class ReplaceAllInLink < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  create_help "replaceallinlink"
  set :prefix, /^@@/
  match /replaceallinlink (.*); (.*); (.+|.?)/, method: :default
  match /replaceallinlink (.+); (.*); (.*); (.+|.?)/, method: :execute
  
  def default(msg, link, oldtext, newtext)
    execute(msg, WIKI_CORE, link, oldtext, newtext)
  end
  
  def execute(msg, wiki, link, oldtext, newtext)
    if is_op? msg.user.authname, wiki
      client = get_client(wiki)
      client.what_links_here(link).each do |page|
        text = client.get_text(page)
        client.edit(page, text.gsub(oldtext, irc_escape(newtext))) if text.include?(oldtext)
      end
      msg.reply(localize("command.shared.complete"))
    else
      msg.reply(localize("command.shared.unauthorized"))
    end
  end
end
