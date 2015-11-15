class AddCatA < ESAEBSADCommand
  include Cinch::Plugin
  
  set_help("addcata", "Group: owner. Syntax: \"@@add_cata (sub1); (sub2); (name)\"\nThe addcata command will create a new category based on two subcategories.\n\"nil\" can be set as the second subcategory if a second subcategory is not wanted.\nExample: \"@@add_cata Armor; nil; Horse Armor\".")
  set :prefix, /^@@/
  match /add_cata (.*); (.*); (.*)/
  def execute(msg, sub1, sub2, name)
    if msg.user.authname != $OWNER_NAME
      msg.reply "You are not authorized."
      return
    elsif sub2 != "nil"
      get_client.create_page("Category:#{name}", "[[Category:#{sub1}]]\n[[Category:#{sub2}]]", "Created category page.")
    else
      get_client.create_page("Category:#{name}", "[[Category:#{sub1}]]", "Created category page.")
    end
    msg.reply "Here you go: http://ftb.gamepedia.com/Category:#{urlize(name)}"
  end
end
