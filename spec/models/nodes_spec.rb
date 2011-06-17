require 'spec_helper'

describe Node do
  it "is invalid without a title" do
    @node = Fabricate(:node)
    @node.title = nil
    @node.should_not be_valid
  end
  it "is invalid without a description" do
    @node = Fabricate(:node)
    @node.description = nil
    @node.should_not be_valid
  end
  it "responds to relationships" do
    @node = Fabricate(:node)
    @node.should respond_to(:relationships)
  end
  it ".relationships gives you all relationships that include it" do
    @node = Fabricate(:node)
    @node2 = Fabricate(:node)
    @node3 = Fabricate(:node)
    @rel = Relationship.create(:node1 => @node, :node2 => @node2, :sentence1 => "%1 %2", :sentence2 => "%2 %1")
    @rel2 = Relationship.create(:node1 => @node3, :node2 => @node, :sentence1 => "%1 %2", :sentence2 => "%2 %1")
    @node.relationships.should include(@rel)
    @node.relationships.should include(@rel2)
  end
  it "responds to related_nodes" do
    @node = Fabricate(:node)
    @node.should respond_to(:related_nodes)
  end
  it ".related_nodes gives you all related nodes" do
    @node = Fabricate(:node)
    @node2 = Fabricate(:node)
    @node3 = Fabricate(:node)
    @rel = Relationship.create(:node1 => @node, :node2 => @node2, :sentence1 => "%1 %2", :sentence2 => "%2 %1")
    @rel2 = Relationship.create(:node1 => @node3, :node2 => @node, :sentence1 => "%1 %2", :sentence2 => "%2 %1")
    @node.related_nodes.should include(@node2)
    @node.related_nodes.should include(@node3)
  end
end

