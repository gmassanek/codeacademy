require 'spec_helper'

describe Relationship do
  before do
    @rel = Fabricate(:relationship)
  end

  it "populates a sentence with node text" do
    RelHelper::Sentences.should_receive(:populate).with(@rel.sentence1, @rel.node1.to_s, @rel.node2.to_s)
    @rel.populated_sentence(:sentence1)
  end

  it "is invalid if node1 or node2 are blank" do
    @rel.node1 = nil
    @rel.should_not be_valid
    @rel.node1 = @rel.node1
    @rel.node2 = nil
    @rel.should_not be_valid
  end

  it "validates sentences" do
    RelHelper::Sentences.should_receive(:valid_sentence?).with(@rel.sentence1)
    RelHelper::Sentences.should_receive(:valid_sentence?).with(@rel.sentence2)
    @rel.valid?
  end

  describe "relationship key" do
    it "should set the key before validation" do
      RelHelper::Key.should_receive(:create).with(@rel.node1, @rel.node2)
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

  it "gives contextual sentences" do
    @rel.sentence_from(@rel.node1).should == @rel.populated_sentence(:sentence1)
  end

  it "finds the other node" do
    @rel.other_node(@rel.node1).should == @rel.node2
  end

end

