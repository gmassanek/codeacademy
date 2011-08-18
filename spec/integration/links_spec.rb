require 'spec_helper'

describe Link do
  describe "new link" do
    before do
      @node = Fabricate(:node)
      visit new_node_link_path(@node)
    end
    it "saves new links" do
      page.fill_in 'Url', :with => "http://#{@node.title.gsub(" ","")}.com"
      page.click_button 'Create Link'
      page.should have_content("Link created")
    end
    it "shows errors" do
      page.click_button 'Create Link'
      page.should have_content("can't be blank")
    end
  end
  describe "edit link" do
    before do
      @node = Fabricate(:node)
      @link = Fabricate(:node_link, :linkable => @node)
      visit edit_node_link_path(@node, @link)
    end
    it "can edit links" do
      page.fill_in 'link_url', :with => "http://www.google.com"
      page.click_button 'Update Link'
      page.should have_content("Link updated")
    end
    it "shows errors" do
      page.fill_in 'link_url', :with => ""
      page.click_button 'Update Link'
      page.should have_content("can't be blank")
    end
  end
  describe "index link" do
    before do
      @link = Fabricate(:node_link)
    end
    it "shows all links", :broken => true do
      link2 = Fabricate(:node_link)
      visit node_links_path(@link.linkable, @link)
      page.should have_content(@link.to_s)
      page.should have_content(link2.to_s)
    end
    it "has a working edit link" do
      visit node_links_path(@link.linkable, @link)
      page.click_link("editLink_#{@link.id}")
      page.current_path.should == edit_polymorphic_path([@link.linkable, @link])
    end
    it "has a working delete link" do
      visit node_links_path(@link.linkable)
      page.click_link("deleteLink_#{@link.id}")
    end
  end
  describe "show link" do
    before do
      @link = Fabricate(:node_link)
      visit polymorphic_path([@link.linkable, @link])
    end
    it "shows the link title" do
      page.should have_css('h2', :text => @link.to_s)
    end
    it "shows the link Url" do
      page.should have_content("#{@link.url}")
    end
  end
end
