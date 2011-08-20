require 'spec_helper'

describe Hacker do
  
  before(:each) do
    @attr = { :email => "foo@example.com",
              :password => "foobar", 
              :password_confirmation => "foobar"}
  end
  
  it "should create a hacker given valid attributes" do
    Hacker.create!(@attr)
  end
  
  describe "validations" do
    it "should require an email address" do
      Hacker.new(@attr.merge(:email => "")).should_not be_valid
    end

    it "should require a password" do
      Hacker.new(@attr.merge(:password => "")).should_not be_valid
    end

    it "should require a password confirmation" do
      Hacker.new(@attr.merge(:password_confirmation => "")).should_not be_valid
    end

    it "should require matching password and password confirmation" do
      Hacker.new(@attr.merge(:password_confirmation => "barfoo")).should_not be_valid
    end
  end
  
  describe "associations" do
    
    before(:each) do
      @hacker = Hacker.create(@attr)
    end
    
    describe "team associations" do
      it "shoukd have a teams attribute" do
        @hacker.should respond_to(:teams)
      end
    end
  
    describe "submissions associations" do
      it "should have a submissions attribute" do
        @hacker.should respond_to(:submissions)
      end
    end
  
    describe "food associations" do
      it "should have a food attribute" do
        @hacker.should respond_to(:food)
      end
    end
  
    describe "commit associations" do
      it "should have a commits attribute" do
        @hacker.should respond_to(:commits)
      end
    end
  end
  
  describe "admin attribute" do
    
    before(:each) do
      @hacker = Hacker.create!(@attr)
    end
    
    it "should respond to admin" do
      @hacker.should respond_to(:admin)
    end
    
    it "should not be an admin by default" do
      @hacker.should_not be_admin
    end
    
    it "should be convertible to an admin" do
      @hacker.toggle!(:admin)
      @hacker.should be_admin
    end
    
  end

end
