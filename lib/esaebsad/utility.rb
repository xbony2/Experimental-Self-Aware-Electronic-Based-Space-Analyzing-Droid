module ESAEBSAD
  module Utility
    BOT_NAME = "ESAEBSAD"
    FTB_WIKI_CLIENT = MediaWiki::Butt.new "http://ftb.gamepedia.com"
    MINECRAFT_BR_WIKI_CLIENT = MediaWiki::Butt.new "http://minecraft-br.gamepedia.com"
    FTB_WIKI_CLIENT.login(BOT_NAME, File.read("/Users/xbony2/git/IRC-Bot/lib/resources/SEKRET_PASSWORD.confidentual".chomp))
    MINECRAFT_BR_WIKI_CLIENT.login(BOT_NAME, File.read("/Users/xbony2/git/IRC-Bot/lib/resources/SEKRET_PASSWORD.confidentual".chomp))
    OWNER_NAME = "xbony2"
    EMODULES = ["badideas"]
    DATA = {}
    HELP_COMMANDS = {}
    
    def create_help(name, doc)
      HELP_COMMANDS[name] = doc
    end
      
    def get_data(emodule)
      DATA[emodule]
    end
      
    def update_data(emodule = nil)
      if emodule.nil?
        EMODULES.each {|emod| DATA[emod] = get_client.get_text("User:ESAEBSAD/data/#{emod}").split("\n")}
      else
        DATA[emodule] = get_client.get_text("User:ESAEBSAD/data/#{emod}").split("\n")
      end
    end
    
    def get_client(code = "ftb")
      case code
      when "br" then MINECRAFT_BR_WIKI_CLIENT
      when "ftb" then FTB_WIKI_CLIENT
      end
    end

    def urlize(page_name)
      page_name.tr(" ", "_").gsub("'", "%27")
    end
    
    def irc_escape(msg)
      msg.gsub(/\\n/, "\n").gsub(/\\-/, "--")
    end

    # TODO: create a better system.
    def get_group(authname)
      case authname
      when "xbony2" then :owner
      else :all
      end
    end

    def is_part_of_group?(authname, group)
      get_group(authname) == group
    end
  end
end
