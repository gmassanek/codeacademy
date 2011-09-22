require 'spec_helper'

describe User do
  describe "belongs to different objects" do
    it "will always be on a node as created_by and last_updated_by" do
      node = Fabricate(:node)
      node.created_by.should_not be_nil
      node.last_updated_by.should_not be_nil
    end
    it "will always be on a relationship as created_by and last_updated_by" do
      relationship = Fabricate(:relationship)
      relationship.created_by.should_not be_nil
      relationship.last_updated_by.should_not be_nil
    end
    it "will always be on a link as created_by and last_updated_by" do
      link = Fabricate(:node_link)
      link.created_by.should_not be_nil
      link.last_updated_by.should_not be_nil
    end
    it "will always be on a tutorial as created_by and last_updated_by" do
      tutorial = Fabricate(:node_tutorial)
      tutorial.created_by.should_not be_nil
      tutorial.last_updated_by.should_not be_nil
    end
  end
ena
