class Lyrics < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  def initialize(*args)
    super

    @lyric_getter = Lyricfy::Fetcher.new
  end

  create_help "lyrics", <<EOS
Group: owner. Syntax: "@@lyrics (artist); (song)"
The lyrics command will line-by-line state the lyrics of a song.
It is owner-only, since many songs are hundreds of lines long.
EOS
  set :prefix, /^@@/
  match /lyrics (.*); (.*)/
  def execute(msg, artist, song)
    if is_part_of_group? msg.user.authname, :owner
      begin
        lyrics = @lyric_getter.search(artist, song).body.split "\\n"
        lyrics.each {|str| msg.reply(str)}
      rescue NoMethodError
        msg.reply "Song not found! Or it may be broken. Remember: artist; song."
      end
    else
      msg.reply "You are not authorized. Ask #{Variables::OWNER_NAME} for any requests."
    end
  end
end
