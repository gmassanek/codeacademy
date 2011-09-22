require 'spec_helper'

describe Node do
  describe "new page" do
    it "saving new pages", :broken => true do
      visit new_node_path
      title = Faker::Lorem.words(3).join(" ")
      page.fill_in 'Title', :with => title
      page.fill_in 'Description', :with => Faker::Lorem.words(5).join(" ")
      page.click_button 'Create Node'
      page.should have_content("Node created")
    end
    it "has current user saved saving new pages"
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
      page.should have_content("Node updated")
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
      @node = Fabricate(:node, :homepage => "")
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
    describe "tutorials" do
      before do
        @tutorial1 = Fabricate(:node_tutorial)
        @tutorial2 = Fabricate(:node_tutorial, :item => @tutorial1.item)
      end
      it "has a Tutorials section" do
        visit node_path(@tutorial1.item)
        page.should have_css("h3", :text => 'Tutorials')
      end
      it "lists all tutorials for the node" do
        visit node_path(@tutorial1.item)
        page.should have_content(@tutorial1.to_s)
        page.should have_content(@tutorial2.to_s)
      end
      it "has links to its tutorials" do
        visit node_path(@tutorial1.item)
        page.click_link (@tutorial1.title)
        page.current_url.should == polymorphic_url([@tutorial1.item, @tutorial1])
      end
    end
 
  end
  describe "and links" do
    it "has an option to save a link on the show page" do
      node = Fabricate(:node)
      visit node_path(node)
      page.should have_button('addLink')
    end
    it "shows all the links associated" do
      node = Fabricate(:node_with_links)
      node.links.each do |link|
        visit node_path(node)
        page.should have_link(link.url)
      end
    end
    context "js links", :js => true do
      before do
        Capybara.current_driver = :selenium
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
      it "shows 5 brainOn images if node confidence = 5", :current_user => true do
        node = Fabricate(:node)
        rating = Fabricate(:user_knowledge_rating, :knowledgeable => node)
        visit node_path(node)
        page.should have_xpath("//img[@alt='Brainon']", :count => 5)
      end
      it "shows 4 brainOn, 1 brainOff, if node confidence = 4", :current_user => true do
        node = Fabricate(:node, :confidence => 4)
        rating = Fabricate(:user_knowledge_rating, :knowledgeable => node)
        visit node_path(node)
        page.should have_xpath("//img[@alt='Brainon']", :count => 4)
        page.should have_xpath("//img[@alt='Brainoff']", :count => 1)
      end
      it "updates by clicking the images", :js => true do
        node_attributes = Fabricate.attributes_for(:node, :confidence => 2)
        visit new_node_path
        page.fill_in 'Title', :with => node_attributes['title']
        page.fill_in 'Description', :with => node_attributes['description']
        page.click_button 'Create Node'
        page.should have_content("Node created")
        page.find(:css, 'img#confidence_4').click
        page.should have_content("Node updated")
        page.should have_xpath("//img[@alt='Brainon']", :count => 4)
      end
    end
  end
end
