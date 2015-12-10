class ReplaceAllInLink < ESAEBSADCommand
  include Cinch::Plugin
  
  set_help "replaceallinlink", <<EOS
Group: owner. Syntax: "@@replaceallinlink (link); (oldtext); (newtext)"
The replace all in link command will convert all instanences of text in a page linked by the given page to a new text.
EOS
  set :prefix, /^@@/
  match /replaceallinlink (.*); (.*); (.+|.?)/
  def execute(msg, link, oldtext, newtext)
    if is_part_of_group? msg.user.authname, :owner
      get_client.what_links_here(link).each do |page|
        text = get_client.get_text(page)
        get_client.edit(page, text.gsub(oldtext, newtext.gsub(/\\n/, "\n")), summary: "Converting \"#{oldtext}\" to \"#{newtext}\"") if text.include?(oldtext)
      end
      msg.reply "Process complete."
    else
      msg.reply "You are not authorized."
    end
  end
end