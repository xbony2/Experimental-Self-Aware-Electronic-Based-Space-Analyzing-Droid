class Lyrics < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  def initialize(*args)
    super

    @lyric_getter = Lyricfy::Fetcher.new
  end

  create_help "lyrics"
  set :prefix, /^@@/
  match /lyrics (.*); (.*)/
  def execute(msg, artist, song)
    if is_part_of_group? msg.user.authname, "owner"
      begin
        lyrics = @lyric_getter.search(artist, song).body.split "\\n"
        lyrics.each {|str| msg.reply(str)}
      rescue NoMethodError
        msg.reply(localize("command.lyrics.notfound"))
      end
    else
      msg.reply(localize("command.shared.unauthorized"))
    end
  end
end
