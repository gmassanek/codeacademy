require 'spec_helper'

describe Link do
  it "requires a URL" do
    @link = Fabricate(:node_link)
    @link.should be_valid
    @link.url = nil
    @link.should_not be_valid
  end

  it "accepts valid URLs" do
    validURLs = [
          "http://www.google.com",
          "https://hello"
    ]
    validURLs.each do |url|
      @link = Fabricate(:node_link)
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
      @link = Fabricate(:node_link)
      @link.url = url
      @link.should_not be_valid
    end
  end
  it "shows the description as to_s if there is one" do
    @link = Fabricate(:node_link, :description => "A helpful link for this and that")
    @link.to_s.should == "A helpful link for this and that"
  end
  it "shows the url as to_s if there is no description" do
    @link = Fabricate(:node_link, :description => nil)
    @link.to_s.should == @link.url
  end
  it "cannot have a description longer than 140 chars" do
    @link = Fabricate(:node_link)
    @link.description = 145.times.collect {"m"}
    @link.should_not be_valid
  end
end
