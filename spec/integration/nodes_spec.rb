require 'spec_helper'

describe Node do
  describe "new page" do
    it "saving new pages" do
      visit new_node_path
      title = Faker::Lorem.words(3).join(" ")
      page.fill_in 'Title', :with => title
      page.fill_in 'Description', :with => Faker::Lorem.words(5).join(" ")
      page.click_button 'Create Node'
      page.should have_content("Node #{title} created")
    end
    it "shows errors" do
      visit new_node_path
      title = Faker::Lorem.words(3).join(" ")
      page.fill_in 'node_title', :with => title
      page.click_button 'Create Node'
      page.should have_content("can't be blank")
    end
  end
  describe "edit page" do
    before do
      node = Fabricate(:node)
      visit edit_node_path(node)
    end
    it "can edit nodes" do
      title = Faker::Lorem.words(3).join(" ")
      page.fill_in 'node_title', :with => title
      page.click_button 'Update Node'
      page.should have_content("Node #{title} updated")
    end
    it "shows errors" do
      page.fill_in 'node_title', :with =>'' 
      page.click_button 'Update Node'
      page.should have_content("can't be blank")
    end
  end
  describe "index page" do
    before do
      @node = Fabricate(:node)
      visit nodes_path
    end
    it "shows all nodes" do
      node2 = Fabricate(:node)
      visit nodes_path
      page.should have_content(@node.title)
      page.should have_content(node2.title)
    end
    it "has a working edit link" do
      page.click_link("editNode_#{@node.id}")
      page.current_path.should == edit_node_path(@node)
    end
    it "has a working delete link" do
      page.click_link("deleteNode_#{@node.id}")
    end
  end
  describe "show page" do
    before do
      @node = Fabricate(:node)
      @tutorial1 = Fabricate(:tutorial, :node => @node)
      @tutorial2 = Fabricate(:tutorial, :node => @node) 
    end
    it "uses a slug from the title for the URL" do
      @node = Fabricate(:node, :title => "Github")
      visit node_path(@node)
      page.current_url.should include("github")
    end
    it "shows the node description" do
      visit node_path(@node)
      page.should have_content("#{@node.description}")
    end
    it "has a link in the header if there is a homepage" do
      visit node_path(@node)
      page.should have_css('h2 a')
    end
    it "has no link in the header if there is no homepage" do
      @node.update_attributes(:homepage => "")
      visit node_path(@node)
      page.should_not have_link(@node.title)
    end
    it "links to all the nodes related to it" do
      @node2 = Fabricate(:node)
      @node3 = Fabricate(:node)
      @rel = Relationship.create(:node1 => @node, :node2 => @node2, :sentence1 => "%1 %2", :sentence2 => "%2 %1")
      @rel2 = Relationship.create(:node1 => @node3, :node2 => @node, :sentence1 => "%1 %2", :sentence2 => "%2 %1")
      visit node_path(@node)
      page.should have_link(@node2.title)
      page.should have_link(@node3.title)
    end
    it "has a sidebar" do
      visit node_path(@node)
      page.should have_css('.sidebar')
    end
    it "has link to each relationship" do
      @node2 = Fabricate(:node)
      @rel = Fabricate(:relationship, :node1 => @node, :node2 => @node2)
      visit node_path(@node)
      @node.relationships.each do |r|
        page.should have_link("relationshipLink#{r.id}")
      end
    end
    it "shows related nodes in sidebar" do
      @node2 = Fabricate(:node)
      @rel = Fabricate(:relationship, :node1 => @node, :node2 => @node2)
      visit node_path(@node)
      @node.related_nodes.each do |n|
        page.should have_content(n.to_s)
      end
    end
    it "has a Tutorials section" do
      @tutorial1 = Fabricate(:tutorial, :node => @node)
      visit node_path(@node)
      page.should have_content("Tutorials")
    end
    it "lists all tutorials for the node" do
      visit node_path(@node)
      page.should have_content(@tutorial1.title)
      page.should have_content(@tutorial2.title)
    end
    it "has links to its tutorials" do
      visit node_path(@node)
      page.click_link (@tutorial1.title)
      page.current_url.should == tutorial_url(@tutorial1)
    end
 
  end
  describe "and links" do
    it "saves a node with a link" do
      visit new_node_path
      title = Faker::Lorem.words(3).join(" ")
      page.fill_in 'Title', :with => title
      page.fill_in 'Description', :with => Faker::Lorem.words(5).join(" ")
      page.fill_in 'Url', :with => "http://wwww.#{title.gsub(" ","")}.com"
      page.click_button 'Create Node'
      page.should have_content("Node #{title} created")
    end
    it "has 1 link inputs" do
      visit new_node_path
      page.should have_css('label', :text => 'Url', :count => 1)
    end
    it "shows all the links associated" do
      node = Fabricate(:node_with_links)
      node.links.each do |link|
        visit node_path(node)
        page.should have_link(link.url)
      end
    end
    it "doesn't have Helpful Links if there are none" do
      node = Fabricate(:node)
      visit node_path(node)
      page.should_not have_content("Helpful Links")
    end
    it "has 1 link inputs for edit" do
      node = Fabricate(:node)
      visit edit_node_path(node)
      page.should have_css('label', :text => 'Url', :count => 1)
    end
    context "js links", :js => true do
      before do
        Capybara.current_driver = :selenium
      end
      it "has a link to delete each link on the new page" do
        visit new_node_path
        delete_link = page.find_link("Remove Link")
        delete_link.click
        delete_link.should_not be_visible
      end
      it "has a link to delete each link on the edit page", :broken => true do
        #Why won't this one work!?!?!
        node = Fabricate(:node)
        visit edit_node_path(node)
        page.fill_in "Url", :with => "http://www.google.com"
        page.click_button "Update Node"
        visit edit_node_path(node)
        page.click_link("Remove Link")
        page.click_button "Update Node"
        node.links.count.should == 0
      end
      it "has a link to add a link on the new page" do
        visit new_node_path
        count = page.all('a', :text => ("Remove Link")).count
        page.click_link("Add Link")
        page.all('a', :text => ("Remove Link")).count.should == count+1
      end
      after do
        Capybara.use_default_driver
      end
    end
    context "social media links" do
      it "saves social media pages" do
        node = Fabricate(:node)
        visit edit_node_path(node)
        page.fill_in("Github", :with => "gmassanek")
        page.click_button("Update Node")
        visit node_path(node)
        page.should have_css('img', :id => "githubLinkImage")
      end
    end
    context "nodes have confidences" do
    end
  end
end
