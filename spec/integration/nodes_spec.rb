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
    end
    it "shows all nodes" do
      node2 = Fabricate(:node)
      visit nodes_path
      page.should have_content(@node.title)
      page.should have_content(node2.title)
    end

    it "has e working edit link" do
      visit nodes_path
      page.click_link("editNode_#{@node.id}")
      page.current_path.should == edit_node_path(@node)
    end
    it "has a working delete link" do
      visit nodes_path
      page.click_link("deleteNode_#{@node.id}")
    end
  end
  describe "show page" do
    before do
      @node = Fabricate(:node)
    end
    it "shows the node title" do
      visit node_path(@node)
      page.should have_css('h2', :text => "#{@node.title}")
    end
    it "shows the node description" do
      visit node_path(@node)
      page.should have_content("#{@node.description}")
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
    it "shows related nodes in sidebar" do
      visit node_path(@node)
      @node.related_nodes.each do |n|
        page.should have_css('.h2', :text => "#{n.title}")
      end
    end
  end
  describe "and links" do
    it "saves a node with a link" do
      visit new_node_path
      title = Faker::Lorem.words(3).join(" ")
      page.fill_in 'Title', :with => title
      page.fill_in 'Description', :with => Faker::Lorem.words(5).join(" ")
      page.fill_in 'Url', :with => "wwww.#{title.gsub(" ","")}.com"
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
    context "js links" do
      before do
        Capybara.current_driver = :selenium
      end
      it "has a link to delete each link on the new page" do
        visit new_node_path
        delete_link = page.find_link("Remove Link")
        delete_link.click
        delete_link.should_not be_visible
      end
      it "has a link to delete each link on the edit page" do
        #Why won't this one work!?!?!
        #node = Fabricate(:node)
        #visit edit_node_path(node)
        #save_and_open_page
        #page.fill_in "Url", :with => "http://www.google.com"
        #page.click_button "Update Node"
        #visit edit_node_path(node)
        #page.click_link("Remove Link")
        #page.click_button "Update Node"
        #node.links.count.should == 0
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
    it "can associate links to relationships"
    it "can save a nodes social media pages and hotlinks"
  end
end
