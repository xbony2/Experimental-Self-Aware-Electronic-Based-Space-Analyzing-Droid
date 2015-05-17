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
  
PASS_DIR = 'git/IRC-Bot/src/main/ruby/xbony2/ircbot/SEKRET_PASSWORD.confidentual'
DESKTOP_DIR = 'Desktop/'

API_PAGE = 'http://ftb.gamepedia.com/api.php'

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
    m.reply "Owner only commands: @@stop, @@upload, @@lyrics, @@addcat, @@addcata, @@trans."
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
      else
        m.reply "That command isn't important enough to be documented, or doesn't exist."
        m.reply "If it's simple enough, running the command will explain itself."
    end
  end
  
  on :channel, /^@@trans (.*)/ do |m, page|
    if m.user.authname != OWNER_NAME
      m.reply "You are not authorized."
    else
      #puts $other_wiki_bot.get_wikitext(page)
      #puts JSON.parse($other_wiki_bot.get_wikitext(page))["query"]["pages"]
      JSON.parse($other_wiki_bot.get_wikitext(page))["query"]["pages"].each do |revid, data|
        $revid = revid
        break
      end
      
      text = JSON.parse($other_wiki_bot.get_wikitext(page))["query"]["pages"][$revid]["revisions"][0]["*"]
      text = text.gsub(/\[\[/, "{{L|").gsub(/\]\]/, "}}") #Does links
      text = text.gsub(/\{\{Infobox\n/, "{{Infobox{{L}}\n") #Does infobox
      text = text.gsub(/\{\{Infobox mod\n/, "{{Infobox mod{{L}}")
      puts text
      #$wiki_bot.edit(title: page, text: new_text)
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
  
  
  #Uploads file from the desktop
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
  
  # If the bot is kicked, the program stops
  on :leaving do |m, user|
    exit if user.nick == BOT_NAME
  end
end

bot.start
