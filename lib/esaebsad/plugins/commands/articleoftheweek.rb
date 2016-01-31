class ArticleOfTheWeek < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  create_help "articleoftheweek", <<EOS
Group: all. Syntax: "@@articleoftheweek [wiki]"
The article of the week command creates a new article of the week using an extremely advanced algolrithm.
EOS
  set :prefix, /^@@/
  match "articleoftheweek", method: :default
  match /articleoftheweek (.+)/, method: :execute
  
  def default(msg)
    execute(msg, WIKI_CORE)
  end
  
  def execute(msg, wiki)
    msg.reply "The article of the week is..."
    page = get_client(wiki).get_random_pages[0]
    msg.reply "#{page}! http://#{wiki}.gamepedia.com/#{urlize(page)}"
  end
end
