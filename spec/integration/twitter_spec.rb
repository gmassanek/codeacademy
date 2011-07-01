require 'spec_helper'

describe "Twitter", :twitter => true do
  describe Node do
    it "has a twitter search key"
    it "shows 5 most recent tweets from search on show page" do
      @node = Fabricate(:node)
      visit node_path(@node)
      page.should have_css('div.twitter')
    end
  end
end
