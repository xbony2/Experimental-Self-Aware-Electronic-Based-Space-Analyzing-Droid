class ArticleOfTheWeek < ESAEBSADCommand
  include Cinch::Plugin
  
  set_help("articleoftheweek", "Group: all. Syntax: \"@@articleoftheweek\"\nThe articleoftheweek command creates a new article of the week using an extremely advanced algolrithm.")
  set :prefix, /^@@/
  match "articleoftheweek"
  def execute(msg)
    msg.reply "The article of the week is..."
    page = get_client.get_random_pages[0]
    msg.reply "#{page}! http://ftb.gamepedia.com/#{page.gsub(' ', '_')}"
  end
end