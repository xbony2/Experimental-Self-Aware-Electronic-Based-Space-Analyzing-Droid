class AddCatA < ESAEBSADCommand
  include Cinch::Plugin
  
  set_help("addcata", "Group: owner. Syntax: \"@@addcat (sub1); (sub2); (name)\"\nThe addcata command will create a new category based on two subcategories.\n\"nil\" can be set as the second subcategory if a second subcategory is not wanted.\nExample: \"@@addcata Armor; nil; Horse Armor\".")
  set :prefix, /^@@/
  match /addcata (.*); (.*); (.*)/
  def execute(msg, sub1, sub2, name)
    if msg.user.authname != $OWNER_NAME
      msg.reply "You are not authorized."
      return
    elsif sub2 != "nil"
      get_client.create_page("Category:#{name}", "[[Category:#{sub1}]]\n[[Category:#{sub2}]]", "Created category page.")
    else
      get_client.create_page("Category:#{name}", "[[Category:#{sub1}]]", "Created category page.")
    end
    msg.reply "Here you go: http://ftb.gamepedia.com/Category:#{name.gsub(' ', '_')}"
  end
end
