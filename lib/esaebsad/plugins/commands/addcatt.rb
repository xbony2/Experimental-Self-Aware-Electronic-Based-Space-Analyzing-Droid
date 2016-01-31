class AddCatt < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility
  
  create_help "addcatt", <<EOS
Group: ftbop. Syntax: "@@addcatt (type); (name)"
The addcatt command will create a new category based on the type.
Example: "@@addcatt mod; Thermal Expansion 3".
EOS
  set :prefix, /^@@/
  match /addcatt (.+); (.*)/
  def execute(msg, type, name)
    if is_part_of_group? msg.user.authname, "ftbop"
      case type
      when "mod" then get_client.create_page("Category:#{name}", "[[Category:Mod categories]]\n[[Category:Mods]]", "Created category page.")
      when "minor" then get_client.create_page("Category:#{name}", "[[Category:Mod categories]]\n[[Category:Minor Mods]]", "Created category page.")
      else
        msg.reply "You screwed up. Try again."
        return
      end

      msg.reply "Here you go: http://ftb.gamepedia.com/Category:#{urlize(name)}"
    else
      msg.reply "You are not authorized."
    end
  end
end