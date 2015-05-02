# licensed under MIT: https://gist.github.com/trajing/40d5c8cd5a94913d6a7f
 
require 'net/http'
require 'json'

module FTB_Wiki_Client
 
class WikiClient
  def initialize(api_page, debug = false)
    @api_page = api_page
    @debug = debug
  end
 
  def get_wikitext(page_name)
    params = {
      action: 'query',
      prop: 'revisions',
      rvprop: 'content',
      format: 'json',
      titles: page_name
    }
    req = ((URI(@api_page)).query = URI.encode_www_form params)
    res = Net::HTTP.get_response req
    res.is_a? Net::HTTPSuccess ? JSON.parse(res.body) : nil
  end
end

end
