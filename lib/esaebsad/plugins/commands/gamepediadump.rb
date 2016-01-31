class GamepediaDump < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  create_help "gamepediadump"
  set :prefix, /^@@/
  match "gamepediadump"
  def execute(msg)
    if is_part_of_group? msg.user.authname, "owner"
      domains = File.new("Documents/domains.txt", "w")

      open("http://www.gamepedia.com/wikis").read.match(/&hellip;(.+)&page=(\d\d)/).to_s.sub(/&hellip;(.+)&page=/, "").to_i.times do |n|
        open("http://www.gamepedia.com/wikis?page=#{n + 1}") do |p|
          p.each_line do |l|
            url = l.match(/http:\/\/(.+).gamepedia.com/).to_s
            domains.puts url if url != "" && url != "http://www.gamepedia.com"
          end
        end
      end

      domains.close
    else
      msg.reply(localize("command.shared.unauthorized"))
    end
  end
end
