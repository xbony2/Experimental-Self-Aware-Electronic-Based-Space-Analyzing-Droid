class Trans < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  create_help "trans"
  set :prefix, /^@@/
  match /trans (.*); (.+)/
  def execute(msg, page, special)
    if is_part_of_group? msg.user.authname, "ftbop"
      text = get_client.get_text(page)
      text = text.gsub(/\[\[Category:.+\]\]/){|s| s.gsub /\]\]/, "{{L}}]]"}
      text = text.gsub(/<br\/>/, "<br />")
      text = text.gsub(/<languages\/>/, "<languages />")
      text = text.gsub(/\[\[.+\]\]/){|s| !s.start_with?("[[Category:", "[[File:", "[[wikipedia:", "[[WP:") ? s.gsub(/\[\[/, "{{L|").gsub(/\]\]/, "}}") : s}
      text = text.gsub(/\{\{[Ii]nfobox\n/, "{{Infobox{{L}}\n")
      text = text.gsub(/\{\{[Ii]nfobox mod\n/, "{{Infobox mod{{L}}\n")
      %w(name lore module effects storageslots storage exp modpacks requires dependency neededfor neededforpast requirespast dependecypast description).each do |s|
        text = text.gsub(/\|#{s}=.+\n/){|ns| ns.insert(2 + s.length, "<translate>").insert(-2, "</translate>")}
      end

      text = text.gsub(/\|mod=.+\n/){|s| !s.end_with?("}}\n") ? s.insert(5, "<translate>").insert(-2, "</translate>") : s}
      text = text.gsub(/\{\{Cg\/.+\n/){|s| s.insert(-2, "{{L}}")}
      text = text.gsub(/\{\{Navbox .+\}\}/){|s| s.insert(-3, "{{L}}")}
      text = text.insert(0, "<translate><!--Translators note: this article is part of the [[project:Translation Restoration project|Translation Restoration project]]--></translate>\n") if special == "in"
      get_client.edit(page, text, "Added translation markup.")
      msg.reply "Here you go: http://ftb.gamepedia.com/#{urlize(page)}"
    else
      msg.reply "You are not authorized."
    end
  end
end
