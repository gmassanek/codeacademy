require 'spec_helper'
describe "Site Authentication" do
  before do
    visit destroy_user_session_path
  end
  it "has a sign up link on the home page when you are not signed in", :js => true do
    visit root_path
    page.should have_link('Sign up')
  end
  it "registers you when you fill in username, email, password", :js => true, :broken => true do
    visit new_user_registration_path
    page.fill_in 'Email', :with => 'foo@example.com'
    page.fill_in 'Password', :with => 'password'
    page.fill_in 'Password confirmation', :with => 'password'
    page.click_link_or_button 'Sign up'
    save_and_open_page
    page.should have_content("Welcome")
    visit destroy_user_session_path
    visit new_user_session_path
    page.fill_in 'Email', :with => 'foo@example.com'
    page.fill_in 'Password', :with => 'password'
    page.click_link_or_button 'Sign in'
    page.should have_content("Signed in successfully")
  end
end
