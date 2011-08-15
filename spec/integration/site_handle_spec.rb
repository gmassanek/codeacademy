require 'spec_helper'

describe "SiteHandle" do
  describe "new siteHandle" do
    before do
      @node = Fabricate(:node)
      visit new_node_site_handle_path(@node)
    end
    it "saves new siteHandles" do
      page.fill_in 'Github', :with => "gmassanek"
      page.click_button 'Create Site handle'
      page.should have_content("Site Handle created")
    end
    it "shows errors" do
    end
  end
  describe "edit siteHandle" do
    before do
      @siteHandle = Fabricate(:site_handle)
      visit edit_polymorphic_path([@siteHandle.item, @siteHandle])
    end
    it "can edit siteHandles" do
      page.fill_in 'Github', :with => "gmassanek"
      page.click_button 'Update Site handle'
      page.should have_content("Site Handle updated")
    end
    it "shows errors" do
    end
  end
  describe "show siteHandle" do
    before do
      @siteHandle = Fabricate(:site_handle)
      @node = @siteHandle.item
    end
    it "shows the siteHandle title" do
      visit polymorphic_path([@node, @siteHandle])
      page.should have_css('h2', :text => @siteHandle.to_s)
    end
    it "shows the siteHandle Url" do
      visit polymorphic_path([@node, @siteHandle])
      page.should have_content("#{@siteHandle.github}")
    end
  end
end
