require 'spec_helper'

describe Link do
  describe "new link" do
    before do
      @node = Fabricate(:node)
      visit new_link_path
      page.select @node.to_s, :from => 'Node'
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
      @link = Fabricate(:link)
      visit edit_link_path(@link)
    end
    it "can edit links" do
      page.fill_in 'link_url', :with => "http://www.google.com"
      page.click_button 'Update Link'
      page.should have_content("Link updated")
    end
    it "shows errors" do
      page.fill_in 'link_url', :with => nil
      page.click_button 'Update Link'
      page.should have_content("can't be blank")
    end
  end
  describe "index link" do
    before do
      @link = Fabricate(:link)
    end
    it "shows all links" do
      link2 = Fabricate(:link)
      visit links_path
      page.should have_content(@link.to_s)
      page.should have_content(link2.to_s)
    end
    it "has a working edit link" do
      visit links_path
      page.click_link("editLink_#{@link.id}")
      page.current_path.should == edit_link_path(@link)
    end
    it "has a working delete link" do
      visit links_path
      page.click_link("deleteLink_#{@link.id}")
    end
  end
  describe "show link" do
    before do
      @link = Fabricate(:link)
    end
    it "shows the link title" do
      visit link_path(@link)
      page.should have_css('h2', :text => @link.to_s)
    end
    it "shows the link Url" do
      visit link_path(@link)
      page.should have_content("#{@link.url}")
    end
  end
end
