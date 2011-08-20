require 'spec_helper'

describe Submission do
  
  before(:each) do
    @team = Factory(:team, :hacker_ids => [Factory(:hacker).id])
    @category = Factory(:category)
    @attr = { :name => "My Hack",
              :description => "This is a description of my hack",
              :team_id => @team.id,
              :category_ids => [1]
              }
  end
  
  it "should create a new instance given valid attributes" do
    Submission.create!(@attr)
  end
  
  describe "validations" do
    
    it "should require a name" do
      Submission.new(@attr.merge(:name => "")).should_not be_valid
    end
    
    it "should require a description" do
      Submission.new(@attr.merge(:description => "")).should_not be_valid
    end
    
    it "should require a team" do
      Submission.new(@attr.merge(:team_id => "")).should_not be_valid
    end
    
    it "should be in at least one category" do
      Submission.new(@attr.merge(:category_ids => [])).should_not be_valid
    end
    
  end
  
  describe "avatars" do
    before(:each) do 
      @submission = Submission.create(@attr)
    end
      
    it "should have the right thumbnail attributes" do
      @submission.should respond_to(:thumbnail_file_name)
      @submission.should respond_to(:thumbnail_content_type)
      @submission.should respond_to(:thumbnail_file_size)
      @submission.should respond_to(:thumbnail_updated_at)
    end
    
    it "should respond to thumbnail as an attached file" do
      @submission.should have_attached_file(:thumbnail)
    end
    
    it "should validate the attached files content type" do
      @submission.should validate_attachment_content_type(:thumbnail).allowing('image/png', 'image/gif').rejecting('text/plain', 'text/xml')
    end
    
    it "should validate the attached files size" do
      @submission.should validate_attachment_size(:thumbnail).less_than(1.megabytes)
    end
  end
  
  describe "team associations" do
    
    before(:each) do
      @submission = Submission.create(@attr)
    end
    
    it "should have a team attribute" do
      @submission.should respond_to(:team)
    end
  end
  
  describe "category associations" do
    before(:each) do
      @submission = Submission.create(@attr)
    end
    
    it "should have a categories attribute" do
      @submission.should respond_to(:categories)
    end
  end
  
  describe "hackers associations" do
    before(:each) do
      @submission = Submission.create(@attr)
    end
    
    it "should have a hackers attribute" do
      @submission.should respond_to(:hackers)
    end
  end
end
