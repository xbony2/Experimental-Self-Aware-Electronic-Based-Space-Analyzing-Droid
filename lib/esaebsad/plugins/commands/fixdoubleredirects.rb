class FixDoubleRedirects < ESAEBSADCommand
	include Cinch::Plugin
    include ESAEBSAD::Utility
    extend ESAEBSAD::Utility

	match /fixdoubleredirects/
    def execute(msg)
      if is_op? msg.user.authname, "ftb"
        get_client.get_doubleredirects_page.each do |redirect| # This won't work so well with triple redirects and self-redirects but hey
			target = get_client.get_text(redirect).sub("#REDIRECT [[", "").sub("]]", "")
			targets_target = get_client.get_text(target).sub("#REDIRECT [[", "").sub("]]", "")
			get_client.edit(redirect, "#REDIRECT [[#{targets_target}]]")
		end

        msg.reply(localize("command.shared.complete"))
      else
        msg.reply(localize("command.shared.unauthorized"))
      end
    end
end
