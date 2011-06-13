require 'spec_helper'

describe Relationship do
  before do
    @node1 = Fabricate(:node)
    @node2 = Fabricate(:node)
    @frag1 = Faker::Lorem.words(2).join(" ")
    @frag2 = Faker::Lorem.words(3).join(" ")
    @frag3 = Faker::Lorem.words(2).join(" ")
    @sentence1 = "#{@frag1} %1 #{@frag2} %2 #{@frag3}}"
    @sentence2 = "#{@frag3} %2 #{@frag1} %1 #{@frag2}}"
    @relationship = Relationship.new(:node1=>@node1, :node2=>@node2, :sentence1 => @sentence1, :sentence2 => @sentence2)
    @relationship.save
  end
  it "is invalid if the sentence 1 is blank" do
    @relationship.sentence1 = nil
    @relationship.should_not be_valid
  end
  it "is invalid if the sentence 2 is blank" do
    @relationship.sentence2 = nil
    @relationship.should_not be_valid
  end
  it "is invalid if the sentence 1 doesn't contain a %1 and a %2" do
    @relationship.sentence1 = "This should be %2 invalid"
    @relationship.should_not be_valid
    @relationship.sentence1 = "This should be %1 invalid"
    @relationship.should_not be_valid
  end
  it "is invalid if the sentence 2 doesn't contain a %1 and a %2" do
    @relationship.sentence2 = "This should be %2 invalid"
    @relationship.should_not be_valid
    @relationship.sentence2 = "This should be %1 invalid"
    @relationship.should_not be_valid
  end
  it "can save new relationships" do
    visit new_relationship_path
    page.select @node1.title, :from => 'Node1'
    page.select @node2.title, :from => 'Node2'
    page.fill_in 'Sentence1', :with => "#{Faker::Lorem.words(4)} %1 #{Faker::Lorem.words(1)} %2 #{Faker::Lorem.words(3)}"
    page.fill_in 'Sentence2', :with => "#{Faker::Lorem.words(4)} %2 #{Faker::Lorem.words(1)} %1 #{Faker::Lorem.words(3)}"
    page.click_button 'Create Relationship'
    page.should have_content("Relationship between #{@node1.title} and #{@node2.title} created.")
  end
  it "show both direction's sentences" do
    visit relationship_path(@relationship) 
    page.should have_content("#{@relationship.sentence1to2}")
    page.should have_content("#{@relationship.sentence2to1}")
  end
end
