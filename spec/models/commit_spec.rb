require 'spec_helper'

describe Commit do

  before(:each) do
    @hacker = Factory(:hacker)
    @attr = { :message => "This is a commit", 
              :user_id => @hacker.id }
  end
  
  it "should create a new instance given vaild attributes" do
    Commit.create!(@attr)
  end 
  
  describe "validations" do
    it "should require a hacker id" do
      Commit.new(@attr.merge(:user_id => "")).should_not be_valid
    end
  end
  
  describe "hacker associations" do
    it "should have a hacker attribute" do
      commit = Commit.create(@attr)
      commit.should respond_to(:hacker)
    end
  end
end