class Info < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  match /info (.*)/, method: :default
  match /info (.+), (.*)/, method: :execute
  
  def default(msg, user)
    execute(msg, WIKI_CORE, user)
  end
  
  def execute(msg, wiki, user)
    client = get_client(wiki)
    msg.reply(localize("command.info", user, client.get_contrib_count(user), client.get_registration_time(user).strftime("%B %e, %Y"), client.get_user_gender(user)))
  end
end
