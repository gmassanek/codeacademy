require 'spec_helper'

describe Tutorial do
  describe "new tutorial" do
    before do
      @node = Fabricate(:node)
      visit new_tutorial_path
      page.select @node.to_s, :from => 'Node'
    end
    it "saves new tutorials" do
      page.fill_in 'Description', :with => "Test description"
      page.fill_in 'Title', :with => "Test title"
      page.click_button 'Create Tutorial'
      page.should have_content("Tutorial created")
    end
    it "shows errors" do
      page.select '', :from => 'Node'
      page.click_button 'Create Tutorial'
      page.should have_content("Node can't be blank")
      page.should have_content("Title can't be blank")
      page.should have_content("Description can't be blank")
    end
  end
  describe "edit tutorial" do
    before do
      @tutorial = Fabricate(:tutorial)
      visit edit_tutorial_path(@tutorial)
    end
#START REDOING TESTS HERE
    it "can edit tutorials" do
      page.fill_in 'Description', :with => "Test description"
      page.click_button 'Update Tutorial'
      page.should have_content("Tutorial updated")
    end
    it "shows errors" do
      page.select '', :from => 'Node'
      page.click_button 'Update Tutorial'
      page.should have_content("can't be blank")
    end
  end
  describe "index Tutorial" do
    before do
      @tutorial = Fabricate(:tutorial)
    end
    it "shows all Tutorials" do
      tutorial2 = Fabricate(:tutorial)
      visit tutorials_path
      page.should have_content(@tutorial.to_s)
      page.should have_content(tutorial2.to_s)
    end
    it "has a working edit tutorial" do
      visit tutorials_path
      page.click_link("editTutorial_#{@tutorial.id}")
      page.current_path.should == edit_tutorial_path(@tutorial)
    end
    it "has a working delete tutorial" do
      visit tutorials_path
      page.click_link("deleteTutorial_#{@tutorial.id}")
    end
  end
  describe "show tutorial" do
    before do
       @tutorial = Fabricate(:tutorial)
    end
    it "shows the tutorial title" do
      visit tutorial_path(@tutorial)
      page.should have_css('h2', :text => @tutorial.to_s)
    end
    it "displays the tutorial title in the index" do
      visit tutorials_path(@tutorial)
      page.should have_css('td', :text => @tutorial.title)
    end

  end
end
