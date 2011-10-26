require_relative '../../app/logic/relationships/key'
require_relative '../../app/logic/relationships/sentences'

describe RelHelper::Sentences do

  it "replaces %1 and %2 with val1 and val2" do
    RelHelper::Sentences.populate("hello %1 and %2", "this", "that").should == "hello this and that"
  end

  it "returns original sentence if either substitution value is nil" do
    RelHelper::Sentences.populate("hello %1 and %2", nil, "that").should == "hello %1 and %2"
  end

  it "defaults val1 and val2 to nil if not supplied" do
    RelHelper::Sentences.populate("hello %1 and %2").should == "hello %1 and %2"
  end

  it "checks a sentence for space holders" do
    sentence = "This %1 should be %2 valid"
    RelHelper::Sentences.has_space_holders?(sentence).should == true
    sentence = "This should be %2 invalid"
    RelHelper::Sentences.has_space_holders?(sentence).should == false
    sentence = "This should be %1 invalid"
    RelHelper::Sentences.has_space_holders?(sentence).should == false
  end

  it "is invalid if a sentence is blank" do
    sentence = nil
    RelHelper::Sentences.valid_sentence?(sentence).should == false
  end

  it "is invalid if a sentence doesn't contain a %1 and a %2" do
    sentence = "%1 missing second part"
    RelHelper::Sentences.should_receive(:has_space_holders?).with(sentence)
    RelHelper::Sentences.valid_sentence?(sentence)
  end

end

describe RelHelper::Key do

  it "creates keys with the smaller id first" do
    id9 = mock(:node, :id => 9)
    id4 = mock(:node, :id => 4)
    id3 = mock(:node, :id => 3)
    RelHelper::Key.create(id9, id4).should == "4:9"
    RelHelper::Key.create(id3, id9).should == "3:9"
  end

  it "returns nil if one of the objects is nil" do
    id9 = mock(:node, :id => 9)
    RelHelper::Key.create(nil, id9).should be_nil
  end

  it "has the same key for reciprocal relationships" do
    id4 = mock(:node, :id => 4)
    id9 = mock(:node, :id => 9)
    RelHelper::Key.create(id9, id4).should == RelHelper::Key.create(id9, id4)
  end

  it "returns nil if it's self-referencing" do
    id4 = mock(:node, :id => 4)
    RelHelper::Key.create(id4, id4).should be_nil
  end

end
