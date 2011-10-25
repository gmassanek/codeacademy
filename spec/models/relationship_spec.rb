require 'spec_helper'

describe Relationship do
  before do
    @rel = Fabricate(:relationship)
  end
  it "displays the relationship from node1 to node2" do
    @rel.sent1.should include(@rel.node1.title)
    @rel.sent1.should include(@rel.node2.title)
  end
  it "displays the relationship from node2 to node1" do
    @rel.sent2.should include(@rel.node1.title)
    @rel.sent2.should include(@rel.node2.title)
  end
  it "doesn't change sentence1 even after calling sentence1to2" do
    sent = @rel.sentence1
    @rel.sent1
    @rel.save
    sent.should == @rel.sentence1
  end
  it "responds to node1" do
    @rel.should respond_to(:node1)
  end
  it "is invalid if the sentence 1 is blank" do
    @rel.sentence1 = nil
    @rel.should_not be_valid
  end
  it "is invalid if the sentence 2 is blank" do
    @rel.sentence2 = nil
    @rel.should_not be_valid
  end
  it "is invalid if the sentence 1 doesn't contain a %1 and a %2" do
    @rel.sentence1 = "This should be %2 invalid"
    @rel.should_not be_valid
    @rel.sentence1 = "This should be %1 invalid"
    @rel.should_not be_valid
  end
  it "is invalid if the sentence 2 doesn't contain a %1 and a %2" do
    @rel.sentence2 = "This should be %2 invalid"
    @rel.should_not be_valid
    @rel.sentence2 = "This should be %1 invalid"
    @rel.should_not be_valid
  end
  it "is invalid if node1 or node2 are blank" do
    @rel.node1 = nil
    @rel.should_not be_valid
    @rel.node1 = @rel.node1
    @rel.node2 = nil
    @rel.should_not be_valid
  end
  it "is valid if %1 or %2 are not separated from other characters by white space" do
    @rel.sentence1 = "(%1) %2"
    @rel.should be_valid
  end

  describe "relationship key" do
    it "should set the key before validation" do
      MyApp::Key.should_receive(:create).with(@rel.node1, @rel.node2)
      @rel.valid?
    end

    it "restricts a key to being unique" do
      @rel2 = @rel.clone
      @rel2.should_not be_valid
    end

    it "is invalid if it could not create a key" do
      @rel.node1 = nil
      @rel.should_not be_valid
    end
  end

  it "responds to .sentence(node)" do
    @rel.sentence_from(@rel.node1).should == @rel.sent1
  end
  it "responds to .other_node(node)" do
    @rel.other_node(@rel.node1).should == @rel.node2
  end

end

