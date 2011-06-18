require 'spec_helper'

describe Relationship do
  before do
    @node1 = Fabricate(:node)
    @node2 = Fabricate(:node)
    @frag1 = Faker::Lorem.words(2).join(" ")
    @frag2 = Faker::Lorem.words(3).join(" ")
    @frag3 = Faker::Lorem.words(2).join(" ")
    @sentence1 = "#{@frag1} %1 #{@frag2} %2 #{@frag3}"
    @sentence2 = "#{@frag3} %2 #{@frag1} %1 #{@frag2}"
    @relationship = Relationship.new(:node1=>@node1, :node2=>@node2, :sentence1 => @sentence1, :sentence2 => @sentence2)
    @relationship.save
  end
  it "displays the relationship from node1 to node2" do
    @relationship.sent1.should == "#{@frag1} #{@node1} #{@frag2} #{@node2} #{@frag3}"
  end
  it "displays the relationship from node2 to node1" do
    @relationship.sent2.should == "#{@frag3} #{@node2} #{@frag1} #{@node1} #{@frag2}"
  end
  it "doesn't change sentence1 even after calling sentence1to2" do
    sent = @relationship.sentence1
    @relationship.sent1
    @relationship.save
    sent.should == @relationship.sentence1
  end
  it "responds to node1" do
    @relationship.should respond_to(:node1)
  end
  it "is invalid if node1 or node2 are blank" do
    @relationship.node1 = nil
    @relationship.should_not be_valid
    @relationship.node1 = @node1
    @relationship.node2 = nil
    @relationship.should_not be_valid
  end
  it "is valid if %1 or %2 are not separated from other characters by white space" do
    @relationship.sentence1 = "(%1) %2"
    @relationship.should be_valid
  end
  describe "relationship key" do
    it "replies to .key function" do
      @relationship.should respond_to(:key)
    end
    it "has the same key as the opposite relationship" do
      @relationship2 = @relationship.clone
      @relationship2.node1 = @node2
      @relationship2.node2 = @node1
      @relationship2.key.should == @relationship.key
    end
    it "restricts a key to being unique" do
      @relationship2 = @relationship.clone
      @relationship2.node1 = @node2
      @relationship2.node2 = @node1
      @relationship2.should_not be_valid
    end
    it "defaults the key and saves it" do
      @relationship.key.should_not be_nil
    end
  end
  it "can't save with the same two nodes" do
    @relationship.node2 = @node1
    @relationship.should_not be_valid
  end
  it "responds to .sentence(node)" do
    @relationship.sentence_from(@node1).should == @relationship.sent1
  end
  it "responds to .other_node(node)" do
    @relationship.other_node(@node1).should == @node2
  end
end

