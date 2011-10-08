require 'spec_helper'

describe Relationship do
  before do
    @relationship = Fabricate(:relationship)
  end
  it "can save new relationships", :current_user => true do
    node = Fabricate(:node)
    visit new_relationship_path
    page.select @relationship.node1.title, :from => 'Node1'
    page.select node.title, :from => 'Node2'
    page.fill_in 'Sentence1', :with => @relationship.sentence1
    page.fill_in 'Sentence2', :with => @relationship.sentence2
    page.click_button 'Create Relationship'
    page.should have_content("Relationship created.")
  end
  describe "show" do
    it "show links to both nodes" do
      visit relationship_path(@relationship) 
      page.should have_link(@relationship.node1.to_s)
      page.should have_link(@relationship.node2.to_s)
    end
    it "should have a URL of node1/node2"
  end
  describe "index" do
    it "shows a relationship's title on the index page" do
      visit relationships_path 
      page.should have_content(@relationship.node1.title) 
    end
    it "has a link to edit the relationship", :current_user => true do
      visit relationships_path
      page.click_link("editRelationship_#{@relationship.id}")
      page.current_path.should == edit_relationship_path(@relationship)
    end
  end
  describe "has links" do
    it "saves a relationship with a link", :current_user => true do
      @relationship = Fabricate(:relationship)
      visit edit_relationship_path(@relationship)
      page.fill_in 'Url',:with => "http://www.google.com"
      page.click_button 'Update Relationship'
      page.should have_content("Relationship updated")
    end
  end
end
