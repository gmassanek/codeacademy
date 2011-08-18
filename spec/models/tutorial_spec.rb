require File.dirname(__FILE__) + '/../spec_helper'

describe Tutorial do
  it "should be valid" do
    @tutorial = Fabricate(:node_tutorial)
    @tutorial.should be_valid
  end
  it "requires a title" do
    @tutorial = Fabricate(:node_tutorial)
    @tutorial.title = nil
    @tutorial.should_not be_valid
  end
  it "requires a description" do
    @tutorial = Fabricate(:node_tutorial)
    @tutorial.description = nil
    @tutorial.should_not be_valid
  end
  it "requires a content" do
    @tutorial = Fabricate(:node_tutorial)
    @tutorial.content = nil
    @tutorial.should_not be_valid
  end
end
