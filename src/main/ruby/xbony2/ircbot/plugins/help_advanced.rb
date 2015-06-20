class Help_Advanced
  include Cinch::Plugin
  
  set :prefix, /^@@/
  match /help (.+)/
  def execute(msg, command)
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
end
