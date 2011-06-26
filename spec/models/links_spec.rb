require 'spec_helper'

describe Link do
  it "requires a node or a relationship and a URL" do
    @link = Fabricate(:node_link)
    @link.should be_valid
    @link.node = nil
    @link.should_not be_valid
  end
  it "requires a node or a relationship and a URL" do
    @link = Fabricate(:relationship_link)
    @link.should be_valid
    @link.relationship = nil
    @link.should_not be_valid
  end
  it "accepts valid URLs" do
    validURLs = [
          "http://www.google.com",
          "https://hello"
    ]
    validURLs.each do |url|
      @link = Fabricate(:link)
      @link.url = url
      @link.should be_valid
    end
  end
  it "rejects invalid URLs" do
    invalidURLs = [
          "google.com",
          "hello",
          "www.google.com"
    ]
    invalidURLs.each do |url|
      @link = Fabricate(:link)
      @link.url = url
      @link.should_not be_valid
    end
  end
end
