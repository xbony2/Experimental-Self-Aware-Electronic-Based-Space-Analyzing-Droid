class Info
  include Cinch::Plugin
  
  set :prefix, /^@@/
  match /info (.+)/
  def execute(msg, usr)
    msg.reply "User: #{usr} | Contribs: #{$ftb_client.get_contrib_count(usr)} | Registered on: #{$ftb_client.get_registration_time(usr).strftime('%B %e, %Y')} | Gender: #{$ftb_client.get_user_gender(usr)}"
  end
end