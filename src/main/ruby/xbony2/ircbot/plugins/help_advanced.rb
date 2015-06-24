class Help_Advanced
  include Cinch::Plugin
  
  set :prefix, /^@@/
  match /help (.+)/
  def execute(msg, command)
    case command
      when "help"
        msg.reply "The help commands gives a list of commands."
        msg.reply "With a parameter, it will give information on a specific command."
      when "url-shorten"
        msg.reply "The URL shorten command takes one parameter, and shortens a link with goo.gl"
      when "archive"
        msg.reply "The archive command takes one parameter, an URL."
        msg.reply "It will backup the site via the Internet Archive (archive.org)."
      when "upload"
        msg.reply "The upload commands takes one parameter, the file's name that is needed to be uploaded."
        msg.reply "This is an owner-only command, as it is a file that comes from the desktop."
      when "lyrics"
        msg.reply "The lyrics commands takes two parameters, the artist, then the song."
        msg.reply "Example: \"@@lyrics Psy; Gangnam Style\"."
        msg.reply "It's owner-only, as many songs are hundreds of lines long."
        msg.reply "This bot has been banned before for \"spam\"."
      when "addcat"
        msg.reply "The add category commands takes two parameters, the type, then the name."
        msg.reply "Example: \"@@addcat mod; Thermal Expansion 3\"."
        msg.reply "It's owner-only, since it edits the wiki and can probably be abused."
      when "addcata"
        msg.reply "The advanced add category commands takes three parameters, the first sub category, the second sub category, then the name."
        msg.reply "\"nil\" should be used as the second sub category if there's only one sub category."
        msg.reply "Example: \"@@addcata Armor; nil; Horse Armor\"."
        msg.reply "It's owner-only, since it edits the wiki and can probably be abused."
      when "trans"
        msg.reply "WARNING: that command is currently very WIP!"
        msg.reply "Anyway, it's probably the most intricate command. It prepares a wiki page for translation."
        msg.reply "It takes only one argument: the page name. It's owner-only of course."
      else
        msg.reply "That command isn't important enough to be documented, or doesn't exist."
        msg.reply "If it's simple enough, running the command will explain itself."
      end
    end
end
