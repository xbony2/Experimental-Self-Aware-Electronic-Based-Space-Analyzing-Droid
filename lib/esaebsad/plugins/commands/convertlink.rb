class ConvertLink < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  create_help "convertlink", <<EOS
Group: op. Syntax: "@@convertlink [wiki]; (oldlink); (newlink)"
The convert link command will convert all instanences of a link to a different link.
EOS
  set :prefix, /^@@/
  match /convertlink (.*); (.*)/, method: :default
  match /convertlink (.+); (.*); (.*)/, method: :execute
  
  def default(msg, oldlink, newlink)
    execute(msg, WIKI_CORE, oldlink, newlink)
  end
  
  def execute(msg, wiki, oldlink, newlink)
    if is_op? msg.user.authname, wiki
      get_client.what_links_here(oldlink).each do |page|
        text = get_client.get_text(page)
        get_client.edit(page, text.gsub("[[#{oldlink}]]", "[[#{newlink}]]"), summary: "Converting [[#{oldlink}]] to [[#{newlink}]]") if text.include?(oldlink)
      end
      msg.reply "Process complete."
    else
      msg.reply "You are not authorized."
    end
  end
end
