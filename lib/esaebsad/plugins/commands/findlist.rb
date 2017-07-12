class FindList < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  match /findlist C:(.*)/, method: :category1
  match /findlist L:(.*)/, method: :linkage1
  match /findlist N:(.*)/, method: :namespace1

  match /findlist (.+); C:(.*)/, method: :category2
  match /findlist (.+); L:(.*)/, method: :linkage2
  match /findlist (.+); N:(.*)/, method: :namespace2

  def category1(msg, category)
    category2(msg, WIKI_CORE, category)
  end

  def linkage1(msg, page)
    linkage2(msg, WIKI_CORE, page)
  end

  def namespace1(msg, namespace)
    namespace2(msg, WIKI_CORE, namespace)
  end

  def category2(msg, wiki, category)
    execute(msg, wiki, get_client(wiki).get_category_members("Category:#{category}", "page|file|subcat"))
  end

  def linkage2(msg, wiki, page)
    client = get_client(wiki)
    execute(msg, wiki, client.what_links_here(page).concat(client.get_all_transcluders(page)).uniq)
  end

  def namespace2(msg, wiki, namespace)
    execute(msg, wiki, get_client(wiki).get_all_pages_in_namespace(namespace))
  end

  def execute(msg, wiki, pages)
	list_stuff(msg, pages)
	msg.reply(localize("command.shared.complete"))
  end
end
