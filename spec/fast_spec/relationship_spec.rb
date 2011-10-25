require_relative '../../app/logic/myapp/key'

describe MyApp::Key do

  it "creates keys with the smaller id first" do
    id9 = mock(:node, :id => 9)
    id4 = mock(:node, :id => 4)
    id3 = mock(:node, :id => 3)
    MyApp::Key.create(id9, id4).should == "4:9"
    MyApp::Key.create(id3, id9).should == "3:9"
  end

  it "returns nil if one of the objects is nil" do
    id9 = mock(:node, :id => 9)
    MyApp::Key.create(nil, id9).should be_nil
  end

  it "has the same key for reciprocal relationships" do
    id4 = mock(:node, :id => 4)
    id9 = mock(:node, :id => 9)
    MyApp::Key.create(id9, id4).should == MyApp::Key.create(id9, id4)
  end

  it "returns nil if it's self-referencing" do
    id4 = mock(:node, :id => 4)
    MyApp::Key.create(id4, id4).should be_nil
  end

end
