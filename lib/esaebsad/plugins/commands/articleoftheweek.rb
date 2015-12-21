require_relative '../../variables'

class ArticleOfTheWeek < ESAEBSADCommand
  include Cinch::Plugin

  Variables.set_help "articleoftheweek", <<EOS
Group: all. Syntax: "@@articleoftheweek"
The article of the week command creates a new article of the week using an extremely advanced algolrithm.
EOS
  set :prefix, /^@@/
  match "articleoftheweek"
  def execute(msg)
    msg.reply "The article of the week is..."
    page = get_client.get_random_pages[0]
    msg.reply "#{page}! http://ftb.gamepedia.com/#{urlize(page)}"
  end
end
