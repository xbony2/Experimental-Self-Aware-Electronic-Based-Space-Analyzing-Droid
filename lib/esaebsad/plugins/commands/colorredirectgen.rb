class ColorRedirectGen < ESAEBSADCommand
	include Cinch::Plugin
    include ESAEBSAD::Utility
    extend ESAEBSAD::Utility
	
	match /colorredirectgen (.*); (.*)/
    def execute(msg, name, target)
      if is_op? msg.user.authname, "ftb"
        ["White", "Orange", "Magenta", "Light Blue", "Yellow", "Lime", "Pink", "Gray", "Light Gray", "Cyan", "Purple", "Blue", "Brown", "Green", "Red", "Black"].each do |color|
        	get_client.create_page(name.sub("$color", color), "#REDIRECT [[#{target}]]")
        end

        msg.reply(localize("command.shared.complete"))
      else
        msg.reply(localize("command.shared.unauthorized"))
      end
    end
end
