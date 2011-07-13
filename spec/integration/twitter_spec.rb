require 'spec_helper'

describe "Twitter", :twitter => true do
  describe Node do
    let(:node) {Fabricate(:node, :twitter_search_key => "cnn")}

    it "has a twitter search key" do
      visit edit_node_path(node)
      node.twitter_search_key.should == "cnn"
    end
    it "tests size of twitter images.  View tests?"
    it "shows 5 most recent tweets from search on show page" do
      visit node_path(node)
      page.should have_css('div.tweets')
    end
    it "has links in tweets where there are links" do
      visit node_path(node)
      within('div.tweets' ) do
        page.should have_css('a')
      end
    end
  end
  it "tests the hyperlink, handle, and hash parsers"


end
