require 'spec_helper'

describe Relationship do
  it "displays the relationship from node1 to node2" do
    node1 = Fabricate(:node)
    node2 = Fabricate(:node)
    frag1 = Faker::Lorem.words(2).join(" ")
    frag2 = Faker::Lorem.words(3).join(" ")
    frag3 = Faker::Lorem.words(2).join(" ")
    sentence1 = "#{frag1} %1 #{frag2} %2 #{frag3}}"
    sentence2 = "#{frag3} %2 #{frag1} %1 #{frag2}}"
    relationship = Relationship.new(:node1=>node1, :node2=>node2, :sentence1 => sentence1, :sentence2 => sentence2)
    relationship.save
    relationship.sentence1to2.should = "#{frag1} #{node1} #{frag2} #{node2} #{frag3}}"
  end
end
