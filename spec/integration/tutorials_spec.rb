require 'spec_helper'

describe Tutorial do
  describe "new tutorial" do
    before do
      @node = Fabricate(:node)
      visit new_node_tutorial_path(@node)
    end
    it "saves new tutorials" do
      page.fill_in 'Description', :with => "new description la di da"
      page.fill_in 'Title', :with => "new description la di da"
      page.fill_in 'Content', :with => "new description la di da"
      page.click_button 'Create Tutorial'
      page.should have_content("Successfully created tutorial")
    end
    it "shows errors" do
      page.click_button 'Create Tutorial'
      page.should have_content("can't be blank")
    end
  end
  describe "edit tutorial" do
    before do
      @node = Fabricate(:node)
      @tutorial = Fabricate(:node_tutorial, :item => @node)
      visit edit_node_tutorial_path(@node, @tutorial)
    end
    it "can edit tutorials" do
      page.fill_in 'Description', :with => "new description la di da"
      page.click_button 'Update Tutorial'
      page.should have_content("Successfully updated tutorial")
    end
    it "shows errors" do
      page.fill_in 'Title', :with => ''
      page.click_button 'Update Tutorial'
      page.should have_content("can't be blank")
    end
  end
  describe "index tutorial" do
    before do
      @tutorial = Fabricate(:node_tutorial)
    end
    it "shows all tutorials", :broken => true do
      tutorial2 = Fabricate(:node_tutorial)
      visit node_tutorials_path(@tutorial.item, @tutorial)
      page.should have_content(@tutorial.to_s)
      page.should have_content(tutorial2.to_s)
    end
    it "has a working edit tutorial" do
      visit node_tutorials_path(@tutorial.item, @tutorial)
      page.click_link("editTutorial_#{@tutorial.id}")
      page.current_path.should == edit_polymorphic_path([@tutorial.item, @tutorial])
    end
    it "has a working delete tutorial" do
      visit node_tutorials_path(@tutorial.item)
      page.click_link("deleteTutorial_#{@tutorial.id}")
    end
  end
  describe "show tutorial" do
    before do
      @tutorial = Fabricate(:node_tutorial)
      visit polymorphic_path([@tutorial.item, @tutorial])
    end
    it "shows the tutorial title" do
      page.should have_css('h1', :text => @tutorial.to_s)
    end
    it "shows the tutorial description" do
      page.should have_content("#{@tutorial.description}")
    end
    describe "uses markdown" do
      it "shows headers" do
        (1..5).each do |n|
          hashString = ""
          n.times {hashString = hashString + "#"}
          @tutorial.update_attributes(:content => "#{hashString} Hello")
          visit polymorphic_path([@tutorial.item, @tutorial])
          within("div.tutorialContent") do
            page.should have_css("h#{n}", :text => "Hello")
          end
        end
      end
      it "shows links" do
        @tutorial.update_attributes(:content => "http://www.google.com")
        visit polymorphic_path([@tutorial.item, @tutorial])
        within("div.tutorialContent") do
          page.should have_css("a")
        end
      end
    end
  end
  describe "tutorials" do
    before do
      @tutorial1 = Fabricate(:relationship_tutorial)
      @tutorial2 = Fabricate(:relationship_tutorial, :item => @tutorial1.item)
    end
    it "has a Tutorials section" do
      visit polymorphic_path(@tutorial1.item)
      page.should have_css("h3", :text => 'Tutorials')
    end
    it "lists all tutorials for the relationship" do
      visit polymorphic_path(@tutorial1.item)
      page.should have_content(@tutorial1.to_s)
      page.should have_content(@tutorial2.to_s)
    end
    it "has links to its tutorials" do
      visit polymorphic_path(@tutorial1.item)
      page.click_link (@tutorial1.title)
      page.current_url.should == polymorphic_url([@tutorial1.item, @tutorial1])
    end
  end
end
