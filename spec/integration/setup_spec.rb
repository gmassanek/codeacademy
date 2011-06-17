require 'spec_helper'
require 'capybara/rspec'

describe "basic setup" do
  it "has a title that says Ecosystem" do
    visit root_path
    page.should have_selector 'head title', :text => "Ruby Ecosystem" 
  end
  #it "shows the first node on the root page" do
  #  visit root_path
  #  @node = Fabricate(:node)
  #  page.should have_content @node
  #end
end
