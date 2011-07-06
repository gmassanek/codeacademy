require 'spec_helper'

describe "Twitter", :twitter => true do
  describe Node do
    before do
      @node = Fabricate(:node)
      visit node_path(@node)
    end
    it "has a twitter search key" do
      page.should have_content(@node.twitter_search_key)
    end
    it "shows 5 most recent tweets from search on show page" do
      #had to update title because Faker doesn't usually have twitter results
      @node.update_attribute(:title, "Google")
      visit node_path(@node)
      page.should have_css('div.tweets')
    end
  end
end
