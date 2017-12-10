class FixDoubleRedirects < ESAEBSADCommand
	include Cinch::Plugin
    include ESAEBSAD::Utility
    extend ESAEBSAD::Utility

	match /generatelangcats/
    def execute(msg)
      if is_op? msg.user.authname, "ftb"
        get_client.get_wantedcategories_page.each do |category|
            match = /^Category:(.+)\/(\w{2})$/.match(category)
            get_client.create_page(category, "[[Category:#{match[1]}]]", summary: localize("mw.summary.catcreation")) if !match.nil?
		end

        msg.reply(localize("command.shared.complete"))
      else
        msg.reply(localize("command.shared.unauthorized"))
      end
    end
end
