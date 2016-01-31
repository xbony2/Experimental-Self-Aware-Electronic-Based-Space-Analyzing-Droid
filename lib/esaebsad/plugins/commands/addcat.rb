class AddCat < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  create_help "addcat", <<EOS
Group: ftbop. Syntax: "@@addcat (name); (sub1); [sub2]; [sub3]"
The addcat command will create a new category based on 1-3 subcategories.
EOS
  set :prefix, /^@@/
  match /addcat (.*); (.*)/, method: :one_sub
  match /addcat (.*); (.*); (.*)/, method: :two_sub
  match /addcat (.*); (.*); (.*); (.*)/, method: :three_sub

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
    if is_part_of_group? msg.user.authname, "ftbop"
      text = ""
      sub.each {|s| text << "[[Category:#{s}]]\n"}
      get_client.create_page("Category:#{name}", text, "Created category page.")
      msg.reply "Here you go: http://ftb.gamepedia.com/Category:#{urlize(name)}"
    else
      msg.reply "You are not authorized."
    end
  end
end
