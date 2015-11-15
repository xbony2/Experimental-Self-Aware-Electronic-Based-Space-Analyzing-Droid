class ConvertLink < ESAEBSADCommand
  include Cinch::Plugin
  
  set_help("convert_link", "Group: owner. Syntax: \"@@convert_link (oldlink); (newlink)\"\nThe convert link command will convert all instanences of a link to a different link.")
  set :prefix, /^@@/
  match /convert_link (.*); (.*)/
  def execute(msg, oldlink, newlink)
    if is_part_of_group? msg.user.authname, :owner
      get_client.what_links_here(oldlink).each do |page|
        text = get_client.get_text(page)
        get_client.edit(page, text.gsub(oldlink, newlink), summary: "Converting [[#{oldlink}]] to [[#{newlink}]]") if text.include?(oldlink)
      end
      msg.reply "Process complete."
    else
      msg.reply "You are not authorized."
    end
  end
end