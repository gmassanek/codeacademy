require 'tld'
module  TwitterHelper
  def self.twitter_search_for(search_key, options = {:html => false})
    search = Twitter::Search.new
    results =  search.containing(CGI.escape(search_key)).language("en").result_type("recent").per_page(5).collect {|tweet| tweet}
    if options[:html] == true
      results.each do |tweet| 
        tweet['text'] = hyperlink_parser(tweet['text'], nil, "_blank")
        tweet['text'] = handle_parser(tweet['text'], nil, "_blank")
        tweet['text'] = hash_parser(tweet['text'], nil, "_blank")
      end
    end
    return results
  end

  def self.hyperlink_parser(string, link_class="", target="")
      return string.gsub(/(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/) {|x| TLD.has_valid_tld?(x) ? "<a href='#{x}' target='#{target}' class='#{link_class}'>#{x}</a>" : x}
  end

  def self.handle_parser(string, link_class="", target="")
      return string.gsub(/@(\w+)/) {|x| "<a href='https://twitter.com/#!/#{x.gsub "@", ""}' target='#{target}' class='#{link_class}'>#{x}</a>"}
  end

  def self.hash_parser(string, link_class="", target="")
      return string.gsub(/#(\w+)/) {|x| "<a href='https://twitter.com/search?q=##{x.gsub "#", ""}' target='#{target}' class='#{link_class}'>#{x}</a>"}
  end
end
