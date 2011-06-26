require 'spec_helper'

describe SiteHandle do
  it "requires a node" do
    @siteHandle = Fabricate(:site_handle)
    @siteHandle.should be_valid
    @siteHandle.node = nil
    @siteHandle.should_not be_valid
  end
end

