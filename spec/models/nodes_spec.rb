require 'spec_helper'
require 'twitter'

describe Node do
  let(:node) {Fabricate(:node)}

  it "is invalid without a title" do
    node.title = nil
    node.should_not be_valid
  end
  it "saves it's title as a slug" do
    node.update_attributes(:title => "Test")
    node.cached_slug.should == "test"
  end
  it "prevents duplicate titles" do
    node2 = Fabricate(:node)
    node2.title = node.title
    node2.should_not be_valid
  end
  it "is invalid without a description" do
    node.description = nil
    node.should_not be_valid
  end
  it "responds to relationships" do
    node.should respond_to(:relationships)
  end
  it "responds to related_nodes" do
    node.should respond_to(:related_nodes)
  end

  context "node relationships" do
    let(:node2) {Fabricate(:node)}
    let(:node3) {Fabricate(:node)}

    before do
      @rel = Relationship.create(:node1 => node, :node2 => node2, :sentence1 => "%1 %2", :sentence2 => "%2 %1")
      @rel2 = Relationship.create(:node1 => node3, :node2 => node, :sentence1 => "%1 %2", :sentence2 => "%2 %1")
    end
    
    it "gives you all relationships that include it" do
      node.relationships.should include(@rel)
      node.relationships.should include(@rel2)
    end
    it "gives you all related nodes" do
      node.related_nodes.should include(node2)
      node.related_nodes.should include(node3)
    end
  end

  it "saves a homepage" do
    node.update_attributes(:homepage => "http://www.twitter.com")
    node.should be_valid
  end
  it "should order the links alphabetically" do
    node.update_attributes(:title => "G title")
    node2 = Fabricate(:node, :title => "A title")
    node3 = Fabricate(:node, :title => "Z title")
    Node.all.first.should == node2
    Node.all.last.should == node3
    Node.all.second.should == node
  end
  it "accepts valid URLs" do
    validURLs = ["http://www.google.com",
                  "https://hello"]
    validURLs.each do |url|
      node.homepage = url
      node.should be_valid
    end
  end
  it "rejects invalid URLs" do
    invalidURLs = ["google.com",
                    "hello",
                    "www.google.com"]
    invalidURLs.each do |url|
      node.homepage = url
      node.should_not be_valid
    end
  end
  describe "can have links associated" do
    it "responds to links" do
      node.should respond_to(:links)
    end
    it "accepts attributes for a link" do
      node = Fabricate(:node)
      node.update_attributes :links_attributes => [{:url => 'http://www.google.com'}]
      node.save.should == true
    end
    it "accepts attributes for multiple links" do
      node = Fabricate(:node)
      node.update_attributes :links_attributes => [{:url => 'http://www.google.com'}, {:url => 'http://www.yahoo.com'}]
      node.save.should == true
    end
    it "can save with a link" do
      node = Fabricate(:node_with_links)
      node.links.count.should == 3
    end
  end
  describe "site handles" do
    it "responds to site handles" do
      node.should respond_to(:site_handle)
    end
    it "accepts attributes for a site handle" do
      node = Fabricate(:node)
      node.update_attributes :site_handle_attributes => {:github => 'gmassanek'}
      node.save.should == true
    end
    it "responds to .handles" do
      node.should respond_to(:handles)
    end
  end
  describe "twitter search key" do
    it "searches twitter using the twitter search key" do
      node = Fabricate(:node, :twitter_search_key => "Google")
      node.tweets.size.should == 5
    end
    it "searches twitter using the twitter search key (not title)" do
      node = Fabricate(:node, :twitter_search_key => "Google")
      node.tweets.should_not == TwitterHelper.twitter_search_for(node.title)
    end
    it "has no twitter_search_key by default" do
      node = Fabricate(:node)
      node.twitter_search_key.should be_blank
    end
    it "has no tweets by default" do
      node = Fabricate(:node)
      node.tweets.should be_blank 
    end
  end
  describe "stack overflow search key" do
    it "searches stack overflow using the stack overflow search key" do
      node = Fabricate(:node, :stack_search_key => "Rspec")
      node.stack_results.size.should == 5
    end
    it "has no stack_search_key by default" do
      node = Fabricate(:node)
      node.stack_search_key.should be_blank
    end
    it "has no stack results by default" do
      node = Fabricate(:node)
      node.stack_results.should be_blank 
    end
  end
  describe "has a confidence level" do
      it "of nil by default" do
        node = Fabricate(:node)
        node.confidence.should be_nil
      end
      it "can only be 1-5" do
        node = Fabricate(:node)
        node.confidence = 0
        node.should_not be_valid
      end
      it "can only be 1-5" do
        node = Fabricate(:node)
        node.confidence = 6
        node.should_not be_valid
      end
      it "can only be 1-5" do
        node = Fabricate(:node)
        node.confidence = 3
        node.should be_valid
      end
  end
end

