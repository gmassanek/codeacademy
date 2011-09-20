require 'spec_helper'

describe "Pages" do
  describe "home page" do
    it "has all the Nodes" do
      3.times do Fabricate(:node) end
      visit home_path
      Node.all.each do |n|
        page.should have_content n.to_s
      end
    end
    it "has all the relationships" do
      3.times do Fabricate(:relationship) end
      visit home_path
      Relationship.all.each do |n|
        page.should have_content n.to_s
      end
    end
  end
end
