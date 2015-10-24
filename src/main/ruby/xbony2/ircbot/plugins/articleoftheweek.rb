class ArticleOfTheWeek
  include Cinch::Plugin
  
  set :prefix, /^@@/
  match "articleoftheweek"
  def execute(msg)
    msg.reply "The article of the week is..."
    page = $ftb_client.get_random_pages[0]
    msg.reply "#{page}! http://ftb.gamepedia.com/#{page.gsub(' ', '_')}"
  end
end