require 'spec_helper'

describe Node do
  it "shows current node as top node on page" do
    node = Fabricate(:node)
    visit node_path(node)
    page.should have_content(node.title)
  end
  describe "saving new nodes" do
    it "can save new nodes" do
      visit new_node_path
      title = Faker::Lorem.words(3).join(" ")
      page.fill_in 'Title', :with => title
      page.fill_in 'Description', :with => Faker::Lorem.words(5).join(" ")
      page.click_button 'Create Node'
      page.should have_content("Node #{title} created")
    end
    it "shows errors on the new node page" do
      node = Fabricate(:node)
      visit edit_node_path(node)
      page.fill_in 'Title', :with => nil
      page.click_button 'Update Node'
      page.should have_content("Title can't be blank")
    end
  end
  describe "editing nodes" do
    it "can edit nodes" do
      node = Fabricate(:node)
      visit edit_node_path(node)
      title = Faker::Lorem.words(3).join(" ")
      page.fill_in 'Title', :with => title
      page.click_button 'Update Node'
      page.should have_content("Node #{title} updated")
    end
    it "shows errors on the edit node page" do
      visit new_node_path
      title = Faker::Lorem.words(3).join(" ")
      page.fill_in 'Title', :with => title
      page.click_button 'Create Node'
      page.should have_content("Description can't be blank")
    end
  end
  describe "node navigation" do
    before do
      @node = Fabricate(:node)
    end
    describe "index page" do
      it "shows all nodes on the node index page" do
        node2 = Fabricate(:node)
        visit nodes_path
        page.should have_content(@node.title)
        page.should have_content(node2.title)
      end
      it "has a link to edit node on node index page" do
        visit nodes_path
        page.click_link("editNode_#{@node.id}")
        page.current_path.should == edit_node_path(@node)
      end
      it "has a link to delete node on node index page" do
        visit nodes_path
        page.click_link("deleteNode_#{@node.id}")
      end
    end
    describe "show page" do
      it "shows the node title" do
        visit node_path(@node)
        page.should have_css('h1', :text => "#{@node.title}")
      end
      it "shows the node description" do
        visit node_path(@node)
        page.should have_content("#{@node.description}")
      end
      it "shows all the nodes related to it"
    end
  end
end
