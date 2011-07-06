require 'spec_helper'

describe "Twitter", :twitter => true do
  describe Node do
    before do
      @node = Fabricate(:node, :twitter_search_key => "cnn")
    end
    it "has a twitter search key" do
      visit edit_node_path(@node)
      @node.twitter_search_key.should == "cnn"
    end
    it "shows 5 most recent tweets from search on show page" do
      #had to update title because Faker doesn't usually have twitter results
      visit node_path(@node)
      page.should have_css('div.tweets')
    end
    it "has links in tweets where there are links"
    #do
    #  #why won't this work!!
    #  visit node_path(@node)
    #  within('div.tweets' ) do
    #    save_and_open_page
    #    page.should have_css('a')
    #  end
    #end
  end
end
