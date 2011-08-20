require 'spec_helper'

describe Food do

  before(:each) do
    @attr = { :name => "Cheese Pizza",
              :category => "Pizza"}
  end
  
  it "should create a new instance given valid attributes" do
    Food.create!(@attr)
  end
  
  describe "validations" do
    
    it "should require a name" do
      Food.new(@attr.merge(:name => "")).should_not be_valid
    end
    
    it "should require a category" do
      Food.new(@attr.merge(:category => "")).should_not be_valid
    end
  end
  
  describe "hacker associations" do
    
    before(:each) do
      @food = Food.create(@attr)
    end 
    
    it "should respond to hackers" do
      @food.should respond_to(:hackers)
    end
  end
end
