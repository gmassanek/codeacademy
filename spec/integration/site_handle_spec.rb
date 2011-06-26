require 'spec_helper'

describe "SiteHandle" do
  describe "new siteHandle" do
    before do
      @node = Fabricate(:node)
      visit new_site_handle_path
      page.select @node.to_s, :from => 'Node'
    end
    it "saves new siteHandles" do
      page.fill_in 'Github', :with => "gmassanek"
      page.click_button 'Create Site handle'
      page.should have_content("Site Handle created")
    end
    it "shows errors" do
      page.select '', :from => 'Node'
      page.click_button 'Create Site handle'
      page.should have_content("can't be blank")
    end
  end
  describe "edit siteHandle" do
    before do
      @siteHandle = Fabricate(:site_handle)
      visit edit_site_handle_path(@siteHandle)
    end
    it "can edit siteHandles" do
      page.fill_in 'Github', :with => "gmassanek"
      page.click_button 'Update Site handle'
      page.should have_content("Site Handle updated")
    end
    it "shows errors" do
      page.select '', :from => 'Node'
      page.click_button 'Update Site handle'
      page.should have_content("can't be blank")
    end
  end
  describe "index site Handle" do
    before do
      @siteHandle = Fabricate(:site_handle)
    end
    it "shows all site Handles" do
      siteHandle2 = Fabricate(:site_handle)
      visit site_handles_path
      page.should have_content(@siteHandle.to_s)
      page.should have_content(siteHandle2.to_s)
    end
    it "has a working edit siteHandle" do
      visit site_handles_path
      page.click_link("editSiteHandle_#{@siteHandle.id}")
      page.current_path.should == edit_site_handle_path(@siteHandle)
    end
    it "has a working delete siteHandle" do
      visit site_handles_path
      page.click_link("deleteSiteHandle_#{@siteHandle.id}")
    end
  end
  describe "show siteHandle" do
    before do
      @siteHandle = Fabricate(:site_handle)
    end
    it "shows the siteHandle title" do
      visit site_handle_path(@siteHandle)
      page.should have_css('h2', :text => @siteHandle.to_s)
    end
    it "shows the siteHandle Url" do
      visit site_handle_path(@siteHandle)
      page.should have_content("#{@siteHandle.github}")
    end
  end
end
