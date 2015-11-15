class Info < ESAEBSADCommand
  include Cinch::Plugin
  
  set_help("info", "Group: all. Syntax: \"@@info (usr)\"\nThe info command will give basic information on a user.")
  set :prefix, /^@@/
  match /info (.*)/
  def execute(msg, usr)
    msg.reply "User: #{usr} | Contribs: #{get_client.get_contrib_count(usr)} | Registered on: #{get_client.get_registration_time(usr).strftime('%B %e, %Y')} | Gender: #{get_client.get_user_gender(usr)}"
  end
end