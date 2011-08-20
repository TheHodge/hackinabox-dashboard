require 'spec_helper'

describe HackersController do
  
  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end
  end
  
  describe "POST 'create'" do
  
    describe "failure" do
      before(:each) do
        @attr = { :email => "",
                  :password => "",
                  :password_confirmation => ""}
      end
      
      it "should render the new page" do
        post :create, :hacker => @attr
        response.should render_template(:new)
      end
      
      it "should not create a hacker" do
        lambda do
          post :create, :hacker => @attr
        end.should_not change(Hacker, :count)
      end
    end
                
    
    describe "success" do
      before(:each) do
        @attr = { :email => "foo@example.com",
                  :password => "foobar",
                  :password_confirmation => "foobar"}
      end
      
      it "should redirect to the edit page" do
        post :create, :hacker => @attr
        response.should redirect_to(edit_profile_path(assigns(@attr)))
      end
      
      it "should create a hacker" do
        lambda do
          post :create, :hacker => @attr
        end.should change(Hacker, :count).by(1)
      end
    end
  end
  
  describe "GET 'edit'" do
    
    describe "for non-signed-in users" do
      it "should redirect to the signin page" do
        get :edit
        response.should redirect_to(signin_path)
      end
    end
    
    describe "for signed-in-users" do
      before(:each) do
        @hacker = test_sign_in(Factory(:hacker))
      end
    
      it "should be successful" do
        get :edit
        response.should be_success
      end
    end
  end
  
  describe "PUT 'update'" do
    before(:each) do
      @attr = {:name => "Bar Baz", :description => "This is a description of a hacker"}
      @hacker = Factory(:hacker)
    end
    
    describe "for non-signed-in-users" do
      it "should redirect to the signin page" do
        put :update, :hacker => @attr, :id => 1
        response.should redirect_to(signin_path)
      end
      
      it "should not update the hacker" do
        put :update, :hacker => @attr, :id => 1
        @hacker.reload
        @hacker.description.should_not == @attr[:description]
        @hacker.name.should_not == @attr[:name]
      end
    end
    
    describe "for signed-in-users" do
      
      before(:each) do
        test_sign_in(@hacker)
      end
      
      describe "success" do
      
        it "should update the hacker" do
          put :update, :hacker => @attr, :id => @hacker.id
          @hacker.reload
          @hacker.description.should == @attr[:description]
          @hacker.name.should == @attr[:name]
        end
        
        it "should redirect to the edit page" do
          put :update, :hacker => @attr, :id => @hacker.id
          response.should redirect_to(root_path)
        end
      end
    end
  end
  
  describe "GET 'food'" do
    describe "for non-signed-in users" do
      it "should deny access" do
        get :food
        response.should redirect_to(signin_path)
      end
    end
    
    describe "for signed-in-users" do
      before(:each) do
        test_sign_in(Factory(:hacker, :admin => true))
      end
      
      it "should be successful" do
        get :food
        response.should be_success
      end
    end
  end
  
end
