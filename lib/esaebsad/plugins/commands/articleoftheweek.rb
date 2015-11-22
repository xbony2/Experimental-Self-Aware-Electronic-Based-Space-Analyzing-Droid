class ArticleOfTheWeek < ESAEBSADCommand
  include Cinch::Plugin
  
  set_help "article_of_the_week", <<EOS
Group: all. Syntax: "@@article_of_the_week"
The article of the week command creates a new article of the week using an extremely advanced algolrithm.
EOS
  set :prefix, /^@@/
  match "article_of_the_week"
  def execute(msg)
    msg.reply "The article of the week is..."
    page = get_client.get_random_pages[0]
    msg.reply "#{page}! http://ftb.gamepedia.com/#{urlize(page)}"
  end
end