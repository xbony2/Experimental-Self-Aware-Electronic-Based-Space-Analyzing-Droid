module ESAEBSAD
  module Utility
    CONFIG = YAML.load_file("config.yml")
    
    IRC_SERVER = CONFIG["irc"]["server"]
    IRC_CHANNELS = CONFIG["irc"]["channels"]
    IRC_BOT_NAME = CONFIG["irc"]["nick"]
    IRC_OWNER = CONFIG["irc"]["owner"]
    
    WIKI_CORE = CONFIG["wiki"]["core"]
    WIKI_BOT_NAME = CONFIG["wiki"]["username"]
    
    CLIENTS = {}
    CONFIG["wikis"].each do |wiki, url|
      CLIENTS[wiki] = MediaWiki::Butt.new(url)
      CLIENTS[wiki].login(WIKI_BOT_NAME, CONFIG["wiki"]["password"])
    end
    
    EMODULES = ["badideas", "flirt", "motivate", "quote", "group-ftbop", "group-minecraftbrop", "group-ban"]
    EDATA = {}
    HELP_COMMANDS = {}
    
    @has_edata_init = false
    
    def create_help(name, doc)
      HELP_COMMANDS[name] = doc
    end
      
    def get_data(emodule)
      if !@has_edata_init
        update_data
        @has_edata_init = true
      end
      
      EDATA[emodule]
    end
      
    def update_data(emodule = nil)
      if emodule.nil?
        EMODULES.each {|emod| EDATA[emod] = get_client.get_text("User:ESAEBSAD/data/#{emod}").split("\n")}
      else
        EDATA[emodule] = get_client.get_text("User:ESAEBSAD/data/#{emodule}").split("\n")
      end
    end
    
    def get_client(code = WIKI_CORE)
      CLIENTS[code]
    end

    def urlize(page_name)
      page_name.tr(" ", "_").gsub("'", "%27")
    end
    
    def irc_escape(msg)
      msg.gsub(/\\n/, "\n").gsub(/\\-/, "--")
    end

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
