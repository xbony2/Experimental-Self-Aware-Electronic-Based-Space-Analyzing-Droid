class ConvertLink < ESAEBSADCommand
  include Cinch::Plugin
  
  set :prefix, /^@@/
  match /convertlink (.*); (.*)/
  def execute(msg, oldlink, newlink)
    if msg.user.authname != $OWNER_NAME
      msg.reply "You are not authorized."
    else
      get_client.what_links_here(Regexp.escape(oldlink)).each do |page|
        puts page
        text = get_client.get_text(page)
        get_client.edit(page, text.gsub(oldlink, newlink), summary: "Converting [[#{oldlink}]] to [[#{newlink}]]") if text.include?(oldlink)
      end
      msg.reply "Process complete."
    end
  end
end
