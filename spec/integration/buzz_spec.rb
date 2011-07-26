require 'spec_helper'

describe "Twitter", :twitter => true do
  describe Node do
    let(:node) {Fabricate(:node, :twitter_search_key => "cnn")}

    it "has a twitter search key" do
      visit edit_node_path(node)
      page.find_field("node_twitter_search_key").value.should == "cnn"
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
describe "Stack Overflow" do
  describe Node do
    let(:node) {Fabricate(:node, :stack_search_key => "rspec")}
    it "has a stack search key" do
      visit edit_node_path(node)
      page.find_field("node_stack_search_key").value.should == "rspec"
    end
    it "shows 5 most recent stack questions from search on show page" do
      visit node_path(node)
      page.should have_css('div.stack')
    end
    it "has links to stack overflow in each stack search result" do
      visit node_path(node)
      within('div.stack' ) do
        page.all('a').count.should == 5
      end
    end
  end
end
