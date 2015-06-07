require 'cinch'
require 'httparty'
require 'json'
require 'googl'
require 'rest-client'
require 'open-uri'
require 'mediawiki_api'
require 'lyricfy'
require 'highline'
require 'nokogiri'
require_relative 'ftb_wiki_client'

BOT_NAME = 'ESAEBSAD'
OWNER_NAME = 'xbony2'

NICE_THINGS = ["I love you the way you are.", "You are doing great.", "You're awesome",
  "ERROR: so awesome I don't know what to do.", "I want you.", 
  "I would let you eat my butthole.", "I am unworthy of you eating my butthole.",
  "Fuck that, what about me?", "You're awesome, that's just it.", 
  "Your so awesome I forgot to grammar.", "You're almost as cool as Xbony2.",
  "I'm going to touch you when you aren't looking.", "Give yourself a pat on the back.",
  "It is a good day when you are here.", "You are my savior", "SatanicSanta is smelly"]
  
PASS_DIR = 'git/IRC-Bot/src/main/resources/xbony2/ircbot/SEKRET_PASSWORD.confidentual'
DESKTOP_DIR = 'Desktop/'

API_PAGE = 'http://ftb.gamepedia.com/api.php'

# "mod" moved because of Template:Gc
TRANSLATABLE_PARAMETERS = ["name", "lore", "module", "effects", "storageslots", "storage",
  "exp", "modpacks", "requires", "dependency", "neededfor", "neededforpast", "requirespast",
  "dependecypast", "description"]

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.esper.net"
    c.channels = ["#NuclearControl2", "#FTB-Wiki"]
    c.nick = BOT_NAME
    
    WIKI_PASS = File.read(PASS_DIR)
    $wiki_bot = MediawikiApi::Client.new(API_PAGE)
    $wiki_bot.log_in(BOT_NAME, WIKI_PASS)
    $other_wiki_bot = FTB_Wiki_Client::WikiClient.new(API_PAGE)
    
    $lyric_getter = Lyricfy::Fetcher.new
  end
  
  on :channel, "@@help" do |m|
    m.reply "Commands: @@help, @@flip, @@roll, @@dev, @@motivate, @@url-shorten and @@archive."
    m.reply "Owner only commands: @@stop, @@upload, @@lyrics, @@addcat, @@addcata, and @@trans."
  end
  
  on :channel, /^@@help (.+)/ do |m, command|
    case command
      when "help"
        m.reply "The help commands gives a list of commands."
        m.reply "With a parameter, it will give information on a specific command."
      when "url-shorten"
        m.reply "The URL shorten command takes one parameter, and shortens a link with goo.gl"
      when "archive"
        m.reply "The archive command takes one parameter, an URL."
        m.reply "It will backup the site via the Internet Archive (archive.org)."
      when "upload"
        m.reply "The upload commands takes one parameter, the file's name that is needed to be uploaded."
        m.reply "This is an owner-only command, as it is a file that comes from the desktop."
      when "lyrics"
        m.reply "The lyrics commands takes two parameters, the artist, then the song."
        m.reply "Example: \"@@lyrics Psy; Gangnam Style\"."
        m.reply "It's owner-only, as many songs are hundreds of lines long."
        m.reply "This bot has been banned before for \"spam\"."
      when "addcat"
        m.reply "The add category commands takes two parameters, the type, then the name."
        m.reply "Example: \"@@addcat mod; Thermal Expansion 3\"."
        m.reply "It's owner-only, since it edits the wiki and can probably be abused."
      when "addcata"
        m.reply "The advanced add category commands takes three parameters, the first sub category, the second sub category, then the name."
        m.reply "\"nil\" should be used as the second sub category if there's only one sub category."
        m.reply "Example: \"@@addcata Armor; nil; Horse Armor\"."
        m.reply "It's owner-only, since it edits the wiki and can probably be abused."
      when "trans"
        m.reply "WARNING: that command is currently very WIP!"
        m.reply "Anyway, it's probably the most intricate command. It prepares a wiki page for translation."
        m.reply "It takes only one argument: the page name. It's owner-only of course."
      else
        m.reply "That command isn't important enough to be documented, or doesn't exist."
        m.reply "If it's simple enough, running the command will explain itself."
    end
  end
  
  on :channel, /^@@trans (.*); (.+)/ do |m, page, special|
    if m.user.authname != OWNER_NAME
      m.reply "You are not authorized."
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
      TRANSLATABLE_PARAMETERS.each {|s| #Does parameters
        text = text.gsub(/\|#{s}=.+\n/){|ns| ns.insert(2 + s.length, "<translate>").insert(-2, "</translate>")}
      }
      
      #text = text.gsub(/\|mod=.+\n/){|s| !s.end_with?("}}\n") ? s.gsub(/|mod=.+\n/){|ns| ns.insert(5, "<translate>").insert(-2, "</translate>")} : s}
      #No idea why, but that doesn't work ^
      text = text.gsub(/\{\{Cg\/.+\n/){|s| s.insert(-2, "{{L}}")} # Does crafting grids
      text = text.gsub(/\{\{Navbox .+\}\}/){|s| s.insert(-3, "{{L}}")} #Does navboxes
      text = text.insert(0, "<translate><!--Translators note: you don't needed to translate this line. Just copy-paste it over. Anyway, this page was originally translated before " + 
        "the module was put in place, using whatever older system there was. I made backups of previously translated pages, so you can use them for reference. Checkout: " + 
        "[[UserWiki:Xbony2#My_subpages]--></translate>\n") if special == "in"
      $wiki_bot.edit(title: page, text: text)
      m.reply "Here you go: http://ftb.gamepedia.com/#{page.gsub(' ', '_')}"
    end
  end
  
  on :channel, /^@@addcat (.+); (.*)/ do |m, type, name|
    if m.user.authname != OWNER_NAME
      m.reply "You are not authorized."
    else
      if type == "mod"
        $wiki_bot.create_page("Category:#{name}", "[[Category:Mod categories]]\n[[Category:Mods]]")
      elsif type == "minor"
        $wiki_bot.create_page("Category:#{name}", "[[Category:Mod categories]]\n[[Category:Minor Mods]]")
      else
        m.reply "You screwed up. Try again."
        return
      end
      m.reply "Here you go: http://ftb.gamepedia.com/Category:#{name.gsub(' ', '_')}"
    end
  end
  
  on :channel, /^@@addriovarmor (.*); (.*); (.*); (.*); (.*); (.*); (.*); (.*); (.*); (.*); (.*)/ do |m, name, t1_armor_rating, t1_helmet_dur, t1_chest_dur, t1_leggings_dur, t1_boots_dur, t2_armor_rating, 
    t2_helmet_dur, t2_chest_dur, t2_leggings_dur, t2_boots_dur|
    if m.user.authname != OWNER_NAME
      m.reply "You are not authorized."
    else
      $wiki_bot.create_page("#{name} Helmet", "{{Infobox\n|name=#{name} Helmet\n|imageicon={{Gc|mod=TMOR2|link=none|#{name} Helmet}}\n|mod=The Mists of RioV 2\n|type=armor\n" +
        "|nexttier={{Gc|mod=TMOR2|dis=false|#{name} Helmet Tier II}}\n|armorrating=#{t1_armor_rating}\n|durability=#{t1_helmet_dur}\n}}\n\nThe '''#{name} Helmet''' is an armor added by " +
        "[[The Mists of RioV 2]] mod. It can be upgraded via [[Enhancer]] to get the [[#{name} Helmet Tier II]], or be [[Enchanter|enchanted normally]]. Do note using an enchanted armor piece in the " +
        "Enhancer will wipe away it's enchantments in the upgraded version of the armor.\n\n==Recipe==\n{{Cg/Crafting Table\n|A1={{Gc|mod=TMOR2|dis=false|#{name}}}\n|B1={{Gc|mod=TMOR2|dis=false|#{name}}}" +
        "\n|C1={{Gc|mod=TMOR2|dis=false|#{name}}}\n|A2={{Gc|mod=TMOR2|dis=false|#{name}}}\n|C2={{Gc|mod=TMOR2|dis=false|#{name}}}\n|O={{Gc|mod=TMOR2|link=none|#{name} Helmet}}\n}}\n\n\n" +
        "{{Navbox The Mists of RioV 2}}\n\n[[Category:The Mists of RioV 2]][[Category:Armor]]\n\n<languages/>\n")
      $wiki_bot.create_page("#{name} Chestplate", "{{Infobox\n|name=#{name} Chestplate\n|imageicon={{Gc|mod=TMOR2|link=none|#{name} Chestplate}}\n|mod=The Mists of RioV 2\n|type=armor\n" +
        "|nexttier={{Gc|mod=TMOR2|dis=false|#{name} Chestplate Tier II}}\n|armorrating=#{t1_armor_rating}\n|durability=#{t1_chest_dur}\n}}\n\nThe '''#{name} Chestplate''' is an armor added by " +
        "[[The Mists of RioV 2]] mod. It can be upgraded via [[Enhancer]] to get the [[#{name} Chestplate Tier II]], or be [[Enchanter|enchanted normally]]. Do note using an enchanted armor piece in the " +
        "Enhancer will wipe away it's enchantments in the upgraded version of the armor.\n\n==Recipe==\n{{Cg/Crafting Table\n|A1={{Gc|mod=TMOR2|dis=false|#{name}}}\n|C1={{Gc|mod=TMOR2|dis=false|#{name}}}" +
        "\n|A2={{Gc|mod=TMOR2|dis=false|#{name}}}\n|B2={{Gc|mod=TMOR2|dis=false|#{name}}}\n|C2={{Gc|mod=TMOR2|dis=false|#{name}}}\n|A3={{Gc|mod=TMOR2|dis=false|#{name}}}\n" +
        "|B3={{Gc|mod=TMOR2|dis=false|#{name}}}|C3={{Gc|mod=TMOR2|dis=false|#{name}}}|O={{Gc|mod=TMOR2|link=none|#{name} Chestplate}}\n}}\n\n\n{{Navbox The Mists of RioV 2}}\n\n" +
        "[[Category:The Mists of RioV 2]][[Category:Armor]]\n\n<languages/>\n")
      $wiki_bot.create_page("#{name} Leggings", "{{Infobox\n|name=#{name} Leggings\n|imageicon={{Gc|mod=TMOR2|link=none|#{name} Leggings}}\n|mod=The Mists of RioV 2\n|type=armor\n" +
        "|nexttier={{Gc|mod=TMOR2|dis=false|#{name} Leggings Tier II}}\n|armorrating=#{t1_armor_rating}\n|durability=#{t1_leggings_dur}\n}}\n\nThe '''#{name} Leggings''' is an armor added by " +
        "[[The Mists of RioV 2]] mod. It can be upgraded via [[Enhancer]] to get the [[#{name} Leggings Tier II]], or be [[Enchanter|enchanted normally]]. Do note using an enchanted armor piece in the " +
        "Enhancer will wipe away it's enchantments in the upgraded version of the armor.\n\n==Recipe==\n{{Cg/Crafting Table\n|A1={{Gc|mod=TMOR2|dis=false|#{name}}}\n|B1={{Gc|mod=TMOR2|dis=false|#{name}}}" +
        "\n|C1={{Gc|mod=TMOR2|dis=false|#{name}}}\n|A2={{Gc|mod=TMOR2|dis=false|#{name}}}\n|C2={{Gc|mod=TMOR2|dis=false|#{name}}}\n|A3={{Gc|mod=TMOR2|dis=false|#{name}}}\n" +
        "|C3={{Gc|mod=TMOR2|dis=false|#{name}}}\n|O={{Gc|mod=TMOR2|link=none|#{name} Leggings}}\n}}\n\n\n{{Navbox The Mists of RioV 2}}\n\n[[Category:The Mists of RioV 2]][[Category:Armor]]" +
        "\n\n<languages/>\n")
      $wiki_bot.create_page("#{name} Boots", "{{Infobox\n|name=#{name} Boots\n|imageicon={{Gc|mod=TMOR2|link=none|#{name} Boots}}\n|mod=The Mists of RioV 2\n|type=armor\n" +
        "|nexttier={{Gc|mod=TMOR2|dis=false|#{name} Boots Tier II}}\n|armorrating=#{t1_armor_rating}\n|durability=#{t1_boots_dur}\n}}\n\nThe '''#{name} Boots''' is an armor added by " +
        "[[The Mists of RioV 2]] mod. It can be upgraded via [[Enhancer]] to get the [[#{name} Boots Tier II]], or be [[Enchanter|enchanted normally]]. Do note using an enchanted armor piece in the " +
        "Enhancer will wipe away it's enchantments in the upgraded version of the armor.\n\n==Recipe==\n{{Cg/Crafting Table\n|A1={{Gc|mod=TMOR2|dis=false|#{name}}}\n|C1={{Gc|mod=TMOR2|dis=false|#{name}}}" +
        "\n|A2={{Gc|mod=TMOR2|dis=false|#{name}}}\n|C2={{Gc|mod=TMOR2|dis=false|#{name}}}\n|O={{Gc|mod=TMOR2|link=none|#{name} Boots}}\n}}\n\n\n{{Navbox The Mists of RioV 2}}\n\n" +
        "[[Category:The Mists of RioV 2]][[Category:Armor]]\n\n<languages/>\n")
      $wiki_bot.create_page("#{name} Helmet Tier II", "{{Infobox\n|name=#{name} Helmet Tier II\n|imageicon={{Gc|mod=TMOR2|link=none|#{name} Helmet Tier II}}\n|mod=The Mists of RioV 2\n" +
        "|type=armor\n|prevtier={{Gc|mod=TMOR2|dis=false|#{name} Helmet}}\n|armorrating=#{t2_armor_rating}\n|durability=#{t2_helmet_dur}\n}}\n\nThe '''#{name} Helmet Tier II''' is an armor added by " +
        "[[The Mists of RioV 2]] mod. It as an upgraded version of the [[#{name} Helmet]].\n\n==Recipe==\n{{Cg/Enhancer\n|I1={{Gc|mod=TMOR2|dis=false|Enhancer Gem}}\n" + 
        "|I2={{Gc|mod=TMOR2|dis=false|#{name} Helmet}}\n|O={{Gc|mod=TMOR2|link=false|#{name} Helmet Tier II}}\n}}\n\n\n{{Navbox The Mists of RioV 2}}\n\n[[Category:The Mists of RioV 2]][[Category:Armor]]" +
        "\n\n<languages/>\n")
      $wiki_bot.create_page("#{name} Chestplate Tier II", "{{Infobox\n|name=#{name} Chestplate Tier II\n|imageicon={{Gc|mod=TMOR2|link=none|#{name} Chestplate Tier II}}\n|mod=The Mists of RioV 2\n" +
        "|type=armor\n|prevtier={{Gc|mod=TMOR2|dis=false|#{name} Chestplate}}\n|armorrating=#{t2_armor_rating}\n|durability=#{t2_chest_dur}\n}}\n\n" +
        "The '''#{name} Chestplate Tier II''' is an armor added by [[The Mists of RioV 2]] mod. It as an upgraded version of the [[#{name} Chestplate]].\n\n==Recipe==\n" + 
        "{{Cg/Enhancer\n|I1={{Gc|mod=TMOR2|dis=false|Enhancer Gem}}\n|I2={{Gc|mod=TMOR2|dis=false|#{name} Chestplate}}\n|O={{Gc|mod=TMOR2|link=false|#{name} Chestplate Tier II}}\n}}\n\n\n" +
        "{{Navbox The Mists of RioV 2}}\n\n[[Category:The Mists of RioV 2]][[Category:Armor]]\n\n<languages/>\n")
      $wiki_bot.create_page("#{name} Leggings Tier II", "{{Infobox\n|name=#{name} Leggings Tier II\n|imageicon={{Gc|mod=TMOR2|link=none|#{name} Leggings Tier II}}\n|mod=The Mists of RioV 2\n" +
        "|type=armor\n|prevtier={{Gc|mod=TMOR2|dis=false|#{name} Leggings}}\n|armorrating=#{t2_armor_rating}\n|durability=#{t2_leggings_dur}\n}}\n\n" +
        "The '''#{name} Leggings Tier II''' is an armor added by [[The Mists of RioV 2]] mod. It as an upgraded version of the [[#{name} Leggings]].\n\n==Recipe==\n" + 
        "{{Cg/Enhancer\n|I1={{Gc|mod=TMOR2|dis=false|Enhancer Gem}}\n|I2={{Gc|mod=TMOR2|dis=false|#{name} Leggings}}\n|O={{Gc|mod=TMOR2|link=false|#{name} Leggings Tier II}}\n}}\n\n\n" +
        "{{Navbox The Mists of RioV 2}}\n\n[[Category:The Mists of RioV 2]][[Category:Armor]]\n\n<languages/>\n")
      $wiki_bot.create_page("#{name} Boots Tier II", "{{Infobox\n|name=#{name} Boots Tier II\n|imageicon={{Gc|mod=TMOR2|link=none|#{name} Boots Tier II}}\n|mod=The Mists of RioV 2\n" +
        "|type=armor\n|prevtier={{Gc|mod=TMOR2|dis=false|#{name} Boots}}\n|armorrating=#{t2_armor_rating}\n|durability=#{t2_boots_dur}\n}}\n\n" +
        "The '''#{name} Boots Tier II''' is an armor added by [[The Mists of RioV 2]] mod. It as an upgraded version of the [[#{name} Boots]].\n\n==Recipe==\n" + 
        "{{Cg/Enhancer\n|I1={{Gc|mod=TMOR2|dis=false|Enhancer Gem}}\n|I2={{Gc|mod=TMOR2|dis=false|#{name} Boots}}\n|O={{Gc|mod=TMOR2|link=false|#{name} Boots Tier II}}\n}}\n\n\n" +
        "{{Navbox The Mists of RioV 2}}\n\n[[Category:The Mists of RioV 2]][[Category:Armor]]\n\n<languages/>\n")
    end
  end
  
  on :channel, /^@@addcata (.*); (.*); (.*)/ do |m, sub1, sub2, name|
    if m.user.authname != OWNER_NAME
      m.reply "You are not authorized."
    else
      if sub2 != "nil"
        $wiki_bot.create_page("Category:#{name}", "[[Category:#{sub1}]]\n[[Category:#{sub2}]]")
      else
        $wiki_bot.create_page("Category:#{name}", "[[Category:#{sub1}]]")
      end
      m.reply "Here you go: http://ftb.gamepedia.com/Category:#{name.gsub(' ', '_')}"
    end
  end
  
  on :channel, /^@@lyrics (.*); (.*)/ do |m, artist, song|
    if m.user.authname != OWNER_NAME #restricted because it's basically a spam machine
      m.reply "You are not authorized. Ask #{OWNER_NAME} for any requests."
    else
      lyrics = $lyric_getter.search(artist, song).body.split("\\n")
      lyrics.each do |str|
        m.reply(str)
      end
    end
  end
  
  on :channel, /^@@upload (.+)/ do |m, pic|
    if m.user.authname != OWNER_NAME
      m.reply "You are not authorized."
    else
      $wiki_bot.upload_image(pic, DESKTOP_DIR + pic, 
        "Contact #{OWNER_NAME} with any concerns about this picture.", true)
      m.reply "Picture uploaded: http://ftb.gamepedia.com/File:#{pic}"
    end
  end
  
  on :channel, /^@@archive (.+)/ do |m, site|
    open("http://web.archive.org/save/" + site)
    m.reply("Will be available here shortly: https://web.archive.org/web/*/" + site)
  end
  
  on :channel, "@@motivate" do |m|
    rand = Random.rand(NICE_THINGS.length)
    m.reply(NICE_THINGS.fetch(rand))
  end
  
  on :channel, "@@flip" do |m|
    if 1 + rand(2) == 1
      m.reply "The coin flip reveals heads."
    else
      m.reply "The coin flip reveals tails."
    end
  end
  
  on :channel, "@@roll" do |m|
    m.reply "The die roll reveals the number #{1 + rand(6)}."
  end
  
  on :channel, "@@dev" do |m|
    m.reply "I am an IRC bot created by xbony2 in Ruby, using the cinch gem."
    m.reply "I am open-sourced and under the MIT license: http://goo.gl/GkH1x1"
  end
  
  on :channel, /^@@url-shorten (.+)/ do |m, url|
    shortUrl = Googl.shorten(url)
    m.reply "New URL: #{shortUrl.short_url}"
  end
  
  on :channel, "@@spam" do |m|
    m.reply "I think you should know I'm better then that, #{m.user}."
  end
  
  # Protection
  on :channel, "#{OWNER_NAME} is ugly" do |m|
    if m.user.authname != OWNER_NAME
      m.reply "Shut up, #{m.user}. Your mom is ugly, but not as ugly as you are."
    else
      m.reply "Don't feel so bad about yourself ( ͡° ͜ʖ ͡°) u so sexy."
    end
  end
  
  on :channel, "#{BOT_NAME} is ugly" do |m|
    if m.user.authname != OWNER_NAME
      m.reply "Shut the fuck up, #{m.user}. Your mom is ugly, but not as ugly as you are."
    else
      m.reply "I'm sorry for ever showing my face ;_;"
    end
  end
  
  on :channel, "@@stop" do |m|
    if m.user.authname == OWNER_NAME
      exit # Terminates program
    else
      m.reply "You cannot stop me unless you're my creator."
    end 
  end
end

bot.start
