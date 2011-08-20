require 'spec_helper'

describe Category do
  
  before(:each) do
    @attr = {:name => "Category 1"}
  end
  
  it "should create a new instance given valid attributes" do
    Category.create!(@attr)
  end
  
  it "should require a name" do
    Category.new(@attr.merge(:name => "")).should_not be_valid
  end
  
  it "should have a submissions attribute" do
    category = Category.create(@attr)
    category.should respond_to(:submissions)
  end
  
end
