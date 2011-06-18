require 'spec_helper'

describe Node do
  before do
    @node = Fabricate(:node)
  end
  it "is invalid without a title" do
    @node.title = nil
    @node.should_not be_valid
  end
  it "is invalid without a description" do
    @node.description = nil
    @node.should_not be_valid
  end
  it "responds to relationships" do
    @node.should respond_to(:relationships)
  end
  it "responds to related_nodes" do
    @node.should respond_to(:related_nodes)
  end
  it "gives you all relationships that include it" do
    @node2 = Fabricate(:node)
    @node3 = Fabricate(:node)
    @rel = Relationship.create(:node1 => @node, :node2 => @node2, :sentence1 => "%1 %2", :sentence2 => "%2 %1")
    @rel2 = Relationship.create(:node1 => @node3, :node2 => @node, :sentence1 => "%1 %2", :sentence2 => "%2 %1")
    @node.relationships.should include(@rel)
    @node.relationships.should include(@rel2)
  end
  it "gives you all related nodes" do
    @node2 = Fabricate(:node)
    @node3 = Fabricate(:node)
    @rel = Relationship.create(:node1 => @node, :node2 => @node2, :sentence1 => "%1 %2", :sentence2 => "%2 %1")
    @rel2 = Relationship.create(:node1 => @node3, :node2 => @node, :sentence1 => "%1 %2", :sentence2 => "%2 %1")
    @node.related_nodes.should include(@node2)
    @node.related_nodes.should include(@node3)
  end
  it "has a homepage" do
    @node.should be_valid
  end
  it "prepends www. and http:// if they're not there already" do
    @node.homepage = "google.com"
    @node.save
    @node.homepage.should == "http://www.google.com"
  end
  describe "can have links associated" do
    it "responds to links" do
      @node.should respond_to(:links)
    end
    it "can save with a link" do
      @node = Fabricate(:node_with_links)
      @node.should be_valid
    end
  end
end

