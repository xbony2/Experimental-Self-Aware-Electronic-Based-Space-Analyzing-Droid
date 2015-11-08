$BOT_NAME = 'ESAEBSAD'
$OWNER_NAME = 'xbony2'

$FTB_WIKI_CLIENT = MediaWiki::Butt.new 'http://ftb.gamepedia.com'
$MINECRAFT_BR_WIKI_CLIENT = MediaWiki::Butt.new 'http://minecraft-br.gamepedia.com'

$FTB_WIKI_CLIENT.login($BOT_NAME, File.read('git/IRC-Bot/lib/resources/SEKRET_PASSWORD.confidentual'))
$MINECRAFT_BR_WIKI_CLIENT.login($BOT_NAME, File.read('git/IRC-Bot/lib/resources/SEKRET_PASSWORD.confidentual'))

def get_client(code = "ftb")
  case code
  when "br" then $MINECRAFT_BR_WIKI_CLIENT
  when "ftb" then $FTB_WIKI_CLIENT
  end
end
