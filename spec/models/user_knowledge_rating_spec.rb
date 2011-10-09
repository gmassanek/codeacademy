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
  describe "top_users" do
    it "responds to top_users" do
      UserKnowledgeRating.should respond_to(:top_users)
    end
    it "returns the top 3 users for a given node" do
      node = Fabricate(:node)
      user1 = Fabricate(:user)
      user2 = Fabricate(:user)
      user3 = Fabricate(:user)
      user4 = Fabricate(:user)
      user5 = Fabricate(:user)
      ukr1 = Fabricate(:user_knowledge_rating, :user => user1, :knowledgeable => node, :knowledge_level => 2)
      ukr2 = Fabricate(:user_knowledge_rating, :user => user2, :knowledgeable => node, :knowledge_level => 4)
      ukr3 = Fabricate(:user_knowledge_rating, :user => user3, :knowledgeable => node, :knowledge_level => 3)
      ukr4 = Fabricate(:user_knowledge_rating, :user => user4, :knowledgeable => node, :knowledge_level => 1)
      ukr5 = Fabricate(:user_knowledge_rating, :user => user5, :knowledgeable => node, :knowledge_level => 5)
      UserKnowledgeRating.top_users(node).should == [[user5,5], [user2,4]]
    end
  end
end
