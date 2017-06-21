class Info < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  match /info/, method: :default1
  match /info (.*)/, method: :default2
  match /info (.+); (.*)/, method: :execute

  def default1(msg)
    execute(msg, WIKI_CORE, msg.user.nick)
  end

  def default2(msg, user)
    execute(msg, WIKI_CORE, user)
  end

  def execute(msg, wiki, user)
    client = nil
    if wiki.start_with?("http://", "https://")
      client = MediaWiki::Butt.new(wiki)
    else
      client = get_client(wiki)
    end

    msg.reply(localize("command.info", cap(user), commafy(client.get_contrib_count(cap(user))), client.get_registration_time(cap(user)).strftime("%B %e, %Y"), client.get_user_gender(cap(user))))
  end

  def commafy(int)
    int.to_s.chars.reverse!.each_slice(3).map(&:join).join(",").reverse!
  end

  def cap(str)
    str[0].capitalize + str[1..str.length]
  end
end
