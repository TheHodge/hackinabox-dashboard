require 'spec_helper'

describe Team do
 
  before(:each) do
    @hacker1 = Factory(:hacker)
    @hacker2 = Factory(:hacker, :email => "barbaz@example.com")
    @attr = { :name => "Team Fantastic",
              :description => "This is a team description"}
  end
  
  it "should create a new instance given valid attributes" do
    Team.create!(@attr)
  end
  
  describe "validations" do
    it "should require a name" do
      Team.new(@attr.merge(:name => "")).should_not be_valid
    end
    
    it "should require a unique team name" do
      Team.create(@attr)
      Team.new(@attr).should_not be_valid
    end
    
  end
  
  describe "set permalink method" do
    before(:each) do
      @team = Team.new(@attr)
    end
    
    it "should exist" do
      @team.should respond_to(:set_permalink)
    end
    
    it "should set the teams permalink on save" do
      @team.save
      @team.reload
      @team.permalink.should_not be_blank
    end
  end
      
        
  describe "hacker associations" do
    before(:each) do
      @team = Team.create(@attr)
    end
    
    it "should have a hackers attribute" do
      @team.should respond_to(:hackers)
    end
  end
  
  describe "submission associations" do
    before(:each) do
      @team = Team.create(@attr)
    end
    
    it "should have a submissions attribute" do
      @team.should respond_to(:submissions)
    end
  end
    
end