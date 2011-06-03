require 'spec_helper'

describe Node do
  it "shows current node as top node on page" do
    @node = Fabricate(:node)
    visit node_path(@node)
    page.should have_content(@node.title)
  end
  it "can save new nodes" do
    visit new_node_path
    title = Faker::Lorem.words(3).join(" ")
    page.fill_in 'Title', :with => title
    page.fill_in 'Description', :with => Faker::Lorem.words(5).join(" ")
    page.click_button 'Create Node'
    page.should have_content("Node #{title} created")
  end
end
