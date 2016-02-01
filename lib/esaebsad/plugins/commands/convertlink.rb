class ConvertLink < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  match /convertlink (.*); (.*)/, method: :default
  match /convertlink (.+); (.*); (.*)/, method: :execute
  
  def default(msg, oldlink, newlink)
    execute(msg, WIKI_CORE, oldlink, newlink)
  end
  
  def execute(msg, wiki, oldlink, newlink)
    if is_op? msg.user.authname, wiki
      get_client.what_links_here(oldlink).each do |page|
        text = get_client.get_text(page)
        get_client.edit(page, text.gsub("[[#{oldlink}]]", "[[#{newlink}]]"), summary: localize("mw.summary.linkconvert", oldlink, newlink)) if text.include?(oldlink)
      end
      msg.reply(localize("command.shared.complete"))
    else
      msg.reply(localize("command.shared.unauthorized"))
    end
  end
end
