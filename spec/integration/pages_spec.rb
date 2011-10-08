require 'spec_helper'

describe "Pages" do
  describe "root page" do
    it "has all the Nodes" do
      3.times do Fabricate(:node) end
      visit root_path
      Node.all.each do |n|
        page.should have_content n.to_s
      end
    end
  end
end
