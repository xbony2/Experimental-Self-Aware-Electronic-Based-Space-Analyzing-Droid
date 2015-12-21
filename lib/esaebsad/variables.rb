module Variables
  extend self
  BOT_NAME = "SatanicBot"
  FTB_WIKI_CLIENT = MediaWiki::Butt.new "http://ftb.gamepedia.com"
  MINECRAFT_BR_WIKI_CLIENT = MediaWiki::Butt.new "http://minecraft-br.gamepedia.com"
  # FTB_WIKI_CLIENT.login(BOT_NAME, File.read("#{Dir.pwd}/lib/resources/SEKRET_PASSWORD.confidentual".chomp))
  # MINECRAFT_BR_WIKI_CLIENT.login(BOT_NAME, File.read("#{Dir.pwd}/lib/resources/SEKRET_PASSWORD.confidentual".chomp))
  OWNER_NAME = 'xbony2'

  @help_commands = {}

  def set_help(name, doc)
    @help_commands[name] = doc
  end

  def get_help
    @help_commands
  end
end
