require 'spec_helper'

describe Link do
  describe "new link" do
    before do
      @node = Fabricate(:node)
      visit node_path(@node)
    end
    it "has a new link link" do
      page.should have_button("Add Helpful Link")
    end
    it "pops up a link form rhen you click add Helpful Links",:broken => true, :js => true do
      page.click_button "Add Helpful Link"
      page.should have_css("#newLinkForm")
    end
  end
end
