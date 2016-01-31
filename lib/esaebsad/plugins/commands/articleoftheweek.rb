class ArticleOfTheWeek < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  create_help "articleoftheweek"
  set :prefix, /^@@/
  match "articleoftheweek", method: :default
  match /articleoftheweek (.+)/, method: :execute
  
  def default(msg)
    execute(msg, WIKI_CORE)
  end
  
  def execute(msg, wiki)
    msg.reply(localize("command.articleoftheweek.1"))
    page = get_client(wiki).get_random_pages[0]
    msg.reply(localize("command.articleoftheweek.2", page, "http://#{wiki}.gamepedia.com/#{urlize(page)}"))
  end
end
