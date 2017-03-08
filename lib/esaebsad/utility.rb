module ESAEBSAD
  module Utility
    CONFIG = YAML.load_file("config.yml")
    DEFAULT_LANGUAGE_STRINGS = YAML.load_file("lib/resources/i18n/en.yml")
    LANGUAGE_STRINGS = DEFAULT_LANGUAGE_STRINGS.merge(YAML.load_file("lib/resources/i18n/#{CONFIG["i18n"]}.yml"))

    IRC_SERVER = CONFIG["irc"]["server"]
    IRC_CHANNELS = CONFIG["irc"]["channels"]
    IRC_BOT_NAME = CONFIG["irc"]["nick"]
    IRC_PREFIX = CONFIG["irc"]["prefix"]
    IRC_PREFIX_REGEX = /^#{IRC_PREFIX}/
    IRC_OWNER = CONFIG["irc"]["owner"]

    WIKI_CORE = CONFIG["wiki"]["core"]
    WIKI_BOT_NAME = CONFIG["wiki"]["username"]
    EMODULES = CONFIG["wiki"]["emodules"]

    CLIENTS = {}
    CONFIG["wikis"].each do |wiki, url|
      CLIENTS[wiki] = MediaWiki::Butt.new(url, use_continuation: true, assertion: :bot)
      CLIENTS[wiki].login(CONFIG["wiki"]["loginusername"], CONFIG["wiki"]["password"])
    end

    EDATA = {}

    GROUPS = {}
    CONFIG["wiki"]["groups"].each do |group|
      GROUPS[group] = CLIENTS[WIKI_CORE].get_text("User:#{WIKI_BOT_NAME}/data/group-#{group}").split("\n")
    end

    @@has_edata_init = false

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
      client = CLIENTS[code]
      client.login(WIKI_BOT_NAME, CONFIG["wiki"]["password"]) unless client.user_bot?

      client
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

    def localize(id, str1 = "", str2 = "", str3 = "", str4 = "")
      LANGUAGE_STRINGS[id].sub(/\$1/, str1).sub(/\$2/, str2).sub(/\$3/, str3).sub(/\$4/, str4)
    end
  end
end
