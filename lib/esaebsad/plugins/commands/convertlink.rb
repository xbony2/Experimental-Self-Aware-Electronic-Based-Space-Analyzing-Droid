class ConvertLink < ESAEBSADCommand
  include Cinch::Plugin
  
  set_help("convertlink", "Group: owner. Syntax: \"@@convertlink (oldlink); (newlink)\"\nThe convertlink command will convert all instanences of a link to a different link.")
  set :prefix, /^@@/
  match /convertlink (.*); (.*)/
  def execute(msg, oldlink, newlink)
    if msg.user.authname != $OWNER_NAME
      msg.reply "You are not authorized."
    else
      get_client.what_links_here(oldlink).each do |page|
        text = get_client.get_text(page)
        get_client.edit(page, text.gsub(oldlink, newlink), summary: "Converting [[#{oldlink}]] to [[#{newlink}]]") if text.include?(oldlink)
      end
      msg.reply "Process complete."
    end
  end
end
