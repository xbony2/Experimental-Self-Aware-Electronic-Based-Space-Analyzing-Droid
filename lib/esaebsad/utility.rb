require_relative "variables"

module ESAEBSAD
  module Utility
    def get_client(code = "ftb")
      case code
      when "br" then Variables::MINECRAFT_BR_WIKI_CLIENT
      when "ftb" then Variables::FTB_WIKI_CLIENT
      end
    end

    def urlize(page_name)
      page_name.tr(" ", "_").gsub("'", "%27")
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
