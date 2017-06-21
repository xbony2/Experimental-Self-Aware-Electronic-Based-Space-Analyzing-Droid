class FindReplace < ESAEBSADCommand
  include Cinch::Plugin
  include ESAEBSAD::Utility
  extend ESAEBSAD::Utility

  match /findreplace C:(.*); (.*); (.+|.?)/, method: :category1
  match /findreplace L:(.*); (.*); (.+|.?)/, method: :linkage1
  match /findreplace N:(.*); (.*); (.+|.?)/, method: :namespace1

  match /findreplace (.+); C:(.*); (.*); (.+|.?)/, method: :category2
  match /findreplace (.+); L:(.*); (.*); (.+|.?)/, method: :linkage2
  match /findreplace (.+); N:(.*); (.*); (.+|.?)/, method: :namespace2

  def category1(msg, category, old_text, new_text)
    category2(msg, WIKI_CORE, category, old_text, new_text)
  end

  def linkage1(msg, page, old_text, new_text)
    linkage2(msg, WIKI_CORE, page, old_text, new_text)
  end

  def namespace1(msg, namespace, old_text, new_text)
    namespace2(msg, WIKI_CORE, namespace, old_text, new_text)
  end

  def category2(msg, wiki, category, old_text, new_text)
    execute(msg, wiki, get_client(wiki).get_category_members("Category:#{category}", "page|file|subcat", 5000), localize("mw.category"), category, old_text, new_text)
  end

  def linkage2(msg, wiki, page, old_text, new_text)
    execute(msg, wiki, get_client(wiki).what_links_here(page, 5000), localize("mw.link"), page, old_text, new_text)
  end

  def namespace2(msg, wiki, namespace, old_text, new_text)
    execute(msg, wiki, get_client(wiki).get_all_pages_in_namespace(namespace, 5000), localize("mw.namespace"), namespace, old_text, new_text)
  end

  def execute(msg, wiki, pages, scope, scope_text, old_text, new_text)
    if is_op? msg.user.authname, wiki
      old_text = irc_escape(old_text)
      new_text = irc_escape(new_text)
	  client = get_client(wiki)

      pages.each do |page|
		begin
			text = client.get_text(page)
        	client.edit(page, text.gsub(old_text, new_text), summary: localize("mw.summary.findreplace", old_text, new_text, scope, scope_text)) if text.include?(old_text)
		rescue
			puts "Page #{page} could not be edited!"
		end
      end
      msg.reply(localize("command.shared.complete"))
    else
      msg.reply(localize("command.shared.unauthorized"))
    end
  end
end
