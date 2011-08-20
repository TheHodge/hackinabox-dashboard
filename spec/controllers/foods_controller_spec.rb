require 'spec_helper'

describe FoodsController do
  
  describe "GET 'new'" do
    
    it "should deny access to non-signed-in users" do
      get :new
      response.should redirect_to(signin_path)
    end
    
    it "should deny access to non admin users" do
      test_sign_in(Factory(:hacker))
      get :new
      response.should redirect_to(root_path)
    end
    
    it "should be successful for signed-in-users" do
      test_sign_in(Factory(:hacker, :admin => true))
      get :new
      response.should be_success
    end
  end
  
  describe "POST 'create'" do
    
    before(:each) do
      @attr = {:name => "Cheese Pizza", :category => "Pizza"}
    end
    
    describe "for non-signed-in users" do
      it "should deny access" do
        post :create, :food => @attr
        response.should redirect_to(signin_path)
      end
    end
    
    describe "for non-admin-users" do
      it "should deny access to non admin users" do
        test_sign_in(Factory(:hacker))
        post :create, :food => @attr
        response.should redirect_to(root_path)
      end
    end
    
    describe "for signed-in-admin-users" do
      before(:each) do
        @hacker = test_sign_in(Factory(:hacker, :admin => true))
      end
      
      describe 'failure' do
        it "should render the new page" do
          post :create, :food => @attr.merge(:name => "")
          response.should render_template(:new)
        end
        
        it "should not add food" do
          lambda do
            post :create, :food => @attr.merge(:name => "")
          end.should_not change(Food, :count)
        end
      end
      
      describe 'success' do
        it "should redirect to the add food page" do
          post :create, :food => @attr
          response.should redirect_to(new_food_path)
        end
        
        it "should add food" do
          lambda do
            post :create, :food => @attr
          end.should change(Food, :count).by(1)
        end
      end
    end
  end
end
