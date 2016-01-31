class AddCat < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  create_help "addcat"
  set :prefix, /^@@/
  match /addcat (.*); (.+); (.*)/, method: :one_sub
  match /addcat (.*); (.+); (.*); (.*)/, method: :two_sub
  match /addcat (.*); (.*); (.+); (.*); (.*)/, method: :three_sub

  def one_sub(msg, name, wiki, sub)
    create_categories(msg, name, wiki, [sub])
  end

  def two_sub(msg, name, wiki, sub1, sub2)
    create_categories(msg, name, wiki, [sub1, sub2])
  end

  def three_sub(msg, name, wiki, sub1, sub2, sub3)
    create_categories(msg, name, wiki, [sub1, sub2, sub3])
  end

  def create_categories(msg, name, wiki, sub = [])
    if is_op? msg.user.authname, wiki
      text = ""
      sub.each {|s| text << "[[Category:#{s}]]\n"}
      get_client(wiki).create_page("Category:#{name}", text, "Created category page.")
      msg.reply "Here you go: http://#{wiki}.gamepedia.com/Category:#{urlize(name)}"
    else
      msg.reply "You are not authorized."
    end
  end
end
