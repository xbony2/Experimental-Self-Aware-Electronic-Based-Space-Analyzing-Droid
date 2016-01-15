class AddCatA < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility

  def initialize(*args)
    super
      
    create_help "addcata", <<EOS
Group: owner. Syntax: "@@addcata (name); (sub1); [sub2]; [sub3]"
The addcata command will create a new category based on 1-3 subcategories.
EOS
  end
  
  set :prefix, /^@@/
  match /addcata (.*); (.*)/, method: :one_sub
  match /addcata (.*); (.*); (.*)/, method: :two_sub
  match /addcata (.*); (.*); (.*); (.*)/, method: :three_sub

  def one_sub(msg, name, sub)
    create_categories(msg, name, [sub])
  end

  def two_sub(msg, name, sub1, sub2)
    create_categories(msg, name, [sub1, sub2])
  end

  def three_sub(msg, name, sub1, sub2, sub3)
    create_categories(msg, name, [sub1, sub2, sub3])
  end

  def create_categories(msg, name, sub = [])
    if is_part_of_group? msg.user.authname, :owner
      text = ""
      sub.each {|s| text << "[[Category:#{s}]]\n"}
      get_client.create_page("Category:#{name}", text, "Created category page.")
      msg.reply "Here you go: http://ftb.gamepedia.com/Category:#{urlize(name)}"
    else
      msg.reply "You are not authorized."
    end
  end
end
