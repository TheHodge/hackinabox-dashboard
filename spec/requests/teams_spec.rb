require 'spec_helper'

describe "Teams" do
  
  before(:each) do
    @hacker = Factory(:hacker)
  end
  
  describe "new team" do
    
    describe "authentication" do
      
      it "should redirect to the signin page for non-signed-in users" do
        visit new_team_path
        response.should render_template("hacker_sessions/new")
      end
    end
    
    describe "failure" do
      
      it "should not create a new" do
        lambda do
          visit signin_path
          fill_in "Email",    :with => @hacker.email
          fill_in "Password", :with => @hacker.password
          click_button

          visit new_team_path
          fill_in "Name", :with => ""
          click_button
        response.should render_template("teams/new")
        end.should_not change(Team, :count)
      end
    
    end
    
    describe "success" do
      
      it "should create a team" do
        lambda do
          visit signin_path
          fill_in "Email",    :with => @hacker.email
          fill_in "Password", :with => @hacker.password
          click_button
          
          visit new_team_path
          fill_in "Name", :with => "Team Name"
          fill_in "Description", :with => "This is a description"
          click_button
        response.should render_template("teams/show")
        end.should change(Team, :count).by(1)
      end
    end
  end
end
      