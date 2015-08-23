class Trans
  include Cinch::Plugin
  
  set :prefix, /^@@/
  match /trans (.*); (.+)/
  def execute(msg, page, special)
    if msg.user.authname != $OWNER_NAME
      msg.reply "You are not authorized."
    else
      JSON.parse($other_wiki_bot.get_wikitext(page))["query"]["pages"].each do |revid, data|
        $revid = revid
        break
      end
          
      text = JSON.parse($other_wiki_bot.get_wikitext(page))["query"]["pages"][$revid]["revisions"][0]["*"]
      text = text.gsub(/\[\[Category:.+\]\]/){|s| s.gsub /\]\]/, "{{L}}]]"}
      text = text.gsub(/<br\/>/, "<br />")
      text = text.gsub(/<languages\/>/, "<languages />")
      text = text.gsub(/\[\[.+\]\]/){|s| (!s.start_with?("[[Category:") and !s.start_with?("[[File:")) ? s.gsub(/\[\[/, "{{L|").gsub(/\]\]/, "}}") : s}
      text = text.gsub(/\{\{[Ii]nfobox\n/, "{{Infobox{{L}}\n")
      text = text.gsub(/\{\{[Ii]nfobox mod\n/, "{{Infobox mod{{L}}\n")
      ["name", "lore", "module", "effects", "storageslots", "storage", "exp", "modpacks", "requires", "dependency", "neededfor", "neededforpast", "requirespast",  "dependecypast", "description"].each {|s|
        text = text.gsub(/\|#{s}=.+\n/){|ns| ns.insert(2 + s.length, "<translate>").insert(-2, "</translate>")}
      }
          
      text = text.gsub(/\|mod=.+\n/){|s| !s.end_with?("}}\n") ? s.insert(5, "<translate>").insert(-2, "</translate>") : s}
      text = text.gsub(/\{\{Cg\/.+\n/){|s| s.insert -2, "{{L}}"}
      text = text.gsub(/\{\{Navbox .+\}\}/){|s| s.insert -3, "{{L}}"}
      text = text.insert(0, "<translate><!--Translators note: this article is part of the [[project:Translation Restoration project|Translation Restoration project]]--></translate>\n") if special == "in"
      $wiki_bot.edit(title: page, text: text, bot: 1, summary: "Add translation markup.")
      msg.reply "Here you go: http://ftb.gamepedia.com/#{page.gsub(' ', '_')}"
    end
  end
end
