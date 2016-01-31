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
      sub.each {|s| text << "[[#{localize("mw.category")}:#{s}]]\n"}
      get_client(wiki).create_page("#{localize("mw.category")}:#{name}", text, localize("mw.summary.catcreation"))
      msg.reply(localize("command.shared.link", "http://#{wiki}.gamepedia.com/Category:#{urlize(name)}"))
    else
      msg.reply(localize("command.shared.unauthorized"))
    end
  end
end
