class Info < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  match /info (.*)/, method: :default
  match /info (.+); (.*)/, method: :execute
  
  def default(msg, user)
    execute(msg, WIKI_CORE, user)
  end
  
  def execute(msg, wiki, user)
    client = nil
    if wiki.start_with?("http://", "https://")
      client = MediaWiki::Butt.new(wiki)
    else
      client = get_client(wiki)
    end
    
    msg.reply(localize("command.info", user, commafy(client.get_contrib_count(user)), client.get_registration_time(user).strftime("%B %e, %Y"), client.get_user_gender(user)))
  end
  
  def commafy(int)
    int.to_s.chars.reverse!.each_slice(3).map(&:join).join(",").reverse!
  end
end
