module ESAEBSAD
  module Utility
    CONFIG = YAML.load_file("config.yml")
    
    IRC_SERVER = CONFIG["irc"]["server"]
    IRC_CHANNELS = CONFIG["irc"]["channels"]
    IRC_BOT_NAME = CONFIG["irc"]["nick"]
    IRC_OWNER = CONFIG["irc"]["owner"]
    
    WIKI_CORE = CONFIG["wiki"]["core"]
    WIKI_BOT_NAME = CONFIG["wiki"]["username"]
    EMODULES = CONFIG["wiki"]["emodules"]
    
    CLIENTS = {}
    CONFIG["wikis"].each do |wiki, url|
      CLIENTS[wiki] = MediaWiki::Butt.new(url)
      CLIENTS[wiki].login(WIKI_BOT_NAME, CONFIG["wiki"]["password"])
    end
    
    EDATA = {}
    HELP_COMMANDS = {}
    
    GROUPS = {}
    CONFIG["wiki"]["groups"].each do |group|
      GROUPS[group] = CLIENTS[WIKI_CORE].get_text("User:#{WIKI_BOT_NAME}/data/group-#{group}").split("\n")
    end
    
    @@has_edata_init = false
    
    def create_help(name, doc)
      HELP_COMMANDS[name] = doc
    end
      
    def get_data(emodule)
      if !@@has_edata_init
        update_data
        @@has_edata_init = true
      end
      
      EDATA[emodule]
    end
      
    def update_data(emodule = nil)
      if emodule.nil?
        EMODULES.each {|emod| EDATA[emod] = get_client.get_text("User:#{WIKI_BOT_NAME}/data/#{emod}").split("\n")}
      else
        EDATA[emodule] = get_client.get_text("User:#{WIKI_BOT_NAME}/data/#{emodule}").split("\n")
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

    def get_groups(user)
      groups = []
      groups << "owner" if user == IRC_OWNER
      
      GROUPS.each do |group, users|
        groups << group if users.include?(user)
      end
      
      groups << "all"
    end

    def is_part_of_group?(user, group)
      get_groups(user).include?(group)
    end
    
    def is_op?(user, wiki)
      get_groups(user).include?("#{wiki}-op")
    end
  end
end
