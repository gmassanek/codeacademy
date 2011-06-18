require 'spec_helper'

describe Link do
  it "requires has a node and a URL" do
    @link = Fabricate(:link)
    @link.should be_valid
    @link.node = nil
    @link.should_not be_valid
  end
  it "requires has a node and a URL" do
    @link = Fabricate(:link)
    @link.should be_valid
    @link.url = nil
    @link.should_not be_valid
  end
  it "requires a valid url"
end
