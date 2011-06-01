require 'spec_helper'

describe Node do
  it "shows current node as top node on page" do
    @node = Fabricate(:node)
    visit node_path(@node)
    save_and_open_page
    page.should have_content(@node.title)
  end
end
