class ReplaceAllInCategory
  include Cinch::Plugin
  
  set :prefix, /^@@/
  match /replaceallincategory (.*); (.*); (.+)/
  def execute(msg, cat, oldtext, newtext)
    if msg.user.authname != $OWNER_NAME
      msg.reply "You are not authorized."
    else
      $ftb_client.get_category_members("Category:#{cat}").each do |page| 
        $ftb_client.edit(page, $ftb_client.get_text(page).gsub(/#{oldtext}/, newtext), summary: "Converting \"#{oldtext}\" to \"#{newtext}\"")
      end
      msg.reply "Process complete."
    end
  end
end
