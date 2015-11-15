class AddCatA < ESAEBSADCommand
  include Cinch::Plugin
  
  set_help("addcata", "Group: owner. Syntax: \"@@add_cata (name); (sub1); [sub2]\"\nThe addcata command will create a new category based on one-two subcategories.")
  set :prefix, /^@@/
  match /add_cata (.*); (.*)/, method: :one_sub
  match /add_cata (.*); (.*); (.*)/, method: :two_sub
  
  def one_sub(msg, name, sub)
    if is_part_of_group? msg.user.authname, :owner
      get_client.create_page("Category:#{name}", "[[Category:#{sub1}]]", "Created category page.")
      msg.reply "You are not authorized."
    else
      msg.reply "You are not authorized."
    end
  end
  
  def two_sub(msg, name, sub1, sub2)
    if is_part_of_group? msg.user.authname, :owner
      get_client.create_page("Category:#{name}", "[[Category:#{sub1}]]\n[[Category:#{sub2}]]", "Created category page.")
      msg.reply "Here you go: http://ftb.gamepedia.com/Category:#{urlize(name)}"
    else
      msg.reply "You are not authorized."
    end
  end
end
