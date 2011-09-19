require File.dirname(__FILE__) + '/../spec_helper'

describe UserKnowledgeRating do
  it "should be valid" do
    UserKnowledgeRating.new.should be_valid
  end
  it "has a user" do
    ukr = Fabricate(:user_knowledge_rating)
    ukr.user.class.should_not be_nil
  end
  it "saves defaults user to current user", :broken => true do
    ukr = Fabricate(:user_knowledge_rating)
    ukr.user.should == current_user
  end
end
