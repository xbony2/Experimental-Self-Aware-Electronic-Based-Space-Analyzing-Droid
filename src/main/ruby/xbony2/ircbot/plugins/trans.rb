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
      text = text.gsub(/\[\[Category:.+\]\]/){|s| s.gsub(/\]\]/, "{{L}}]]")} #Does categories
      text = text.gsub(/\[\[.+\]\]/){|s| (!s.start_with?("[[Category:") and !s.start_with?("[[File:")) ? s.gsub(/\[\[/, "{{L|").gsub(/\]\]/, "}}") : s} #Does links
      text = text.gsub(/\{\{[Ii]nfobox\n/, "{{Infobox{{L}}\n") #Does infobox
      text = text.gsub(/\{\{[Ii]nfobox mod\n/, "{{Infobox mod{{L}}\n") #Does infobox mod
      ["name", "lore", "module", "effects", "storageslots", "storage",  "exp", "modpacks", "requires", "dependency", "neededfor", "neededforpast", 
        "requirespast",  "dependecypast", "description"].each {|s| #Does parameters
        text = text.gsub(/\|#{s}=.+\n/){|ns| ns.insert(2 + s.length, "<translate>").insert(-2, "</translate>")}
      }
          
      #text = text.gsub(/\|mod=.+\n/){|s| !s.end_with?("}}\n") ? s.gsub(/|mod=.+\n/){|ns| ns.insert(5, "<translate>").insert(-2, "</translate>")} : s}
      #No idea why, but that doesn't work ^
      text = text.gsub(/\{\{Cg\/.+\n/){|s| s.insert(-2, "{{L}}")} # Does crafting grids
      text = text.gsub(/\{\{Navbox .+\}\}/){|s| s.insert(-3, "{{L}}")} #Does navboxes
      text = text.insert(0, "<translate><!--Translators note: you don't needed to translate this line. Just copy-paste it over. Anyway, this page was originally translated before " + 
        "the module was put in place, using whatever older system there was. I made backups of previously translated pages, so you can use them for reference. Checkout: " + 
        "[[UserWiki:Xbony2#My_subpages]--></translate>\n") if special == "in"
      $wiki_bot.edit(title: page, text: text, bot: 1, summary: "Add translation markup.")
      msg.reply "Here you go: http://ftb.gamepedia.com/#{page.gsub(' ', '_')}"
    end
  end
end
