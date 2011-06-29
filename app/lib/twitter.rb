module  TwitterHelper
  def self.search_twitter_for(query)
    query = CGI.escape(query)
    JSON.parse(
      open("http://search.twitter.com/search.json?q=#{query}").read
    )['results']
  end
end
