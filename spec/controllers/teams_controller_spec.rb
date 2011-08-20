require 'spec_helper'

describe TeamsController do
 
  render_views
 
  describe "GET 'new'" do
    
    describe "for non-signed-in users" do
      it "should redirect to the signin path" do
        get :new
        response.should redirect_to(signin_path)
      end
    end
    
    describe "for signed-in-users" do
      before(:each) do
        @hacker = test_sign_in(Factory(:hacker))
      end
    
      it "should be successful" do
        get :new
        response.should be_success
      end
    end
  end
  
  describe "POST 'create'" do
    
    before(:each) do
      @hacker = Factory(:hacker)
      @attr = {:name => "Teamname", :descriptiob => "This is a team description"}
    end
    
    describe "for non-signed-in users" do
      it "should redirect to the signin path" do
        post :create, :team => @attr
        response.should redirect_to(signin_path)
      end
      
      it "should not create a hacker" do
        lambda do
          post :create, :team => @attr
        end.should_not change(Team, :count)
      end
    end
    
    describe "for signed-in users" do
      
      before(:each) do
        test_sign_in(@hacker)
      end
      
      describe "failure" do
        it "should render the new page" do
          post :create, :team => @attr.merge(:name => "")
          response.should render_template(:new)
        end
        
        it "should not create a team" do
          lambda do 
            post :create, :team => @attr.merge(:name => "")
          end.should_not change(Team, :count)
        end
      end
      
      describe "success" do
        it "should redirect to the show team page" do
          post :create, :team => @attr
          response.should redirect_to(team_path(assigns(:team)))
        end
        
        it "should create a team" do
          lambda do
            post :create, :team => @attr
          end.should change(Team, :count).by(1)
        end
      end
    end
  end  

  describe "GET 'show'" do
    
    before(:each) do
      @hacker = Factory(:hacker, :email => "anotherhacker@example.com") 
      @team = Factory(:team)
    end
      
    describe "for non-signed-in-users" do
      it "should redirect to the signin path" do
        get :show, :id => @team.permalink
        response.should redirect_to(signin_path)
      end
    end
    
    describe "for signed-in-users" do
      
      before(:each) do
        test_sign_in(@hacker)
      end
      
      it "should be successful" do
        get :show, :id => @team.permalink
        response.should be_success
      end
    end
  end

  describe "GET 'index'" do
    
    describe "for non-signed-in users" do
      
      it "should redirect to the signin page" do
        get :index
        response.should redirect_to(signin_path)
      end
    end
    
    describe "for signed-in users" do
      
      before(:each) do
        test_sign_in(Factory(:hacker))
      end
      
      it "should be successful" do
        get :index
        response.should be_success
      end
    end
  end

  describe "GET 'edit'" do
       
    before(:each) do
      @hacker = Factory(:hacker) 
      @team = Factory(:team, :hacker_ids => [@hacker.id], :created_by => @hacker.id)
    end
    
    describe "for non-signed-in users" do
      it "should deny access" do
        get :edit, :id => @team.permalink
        response.should redirect_to(signin_path)
      end
    end
    
    describe "for non-team-members" do
      before(:each) do
        test_sign_in(Factory(:hacker, :email => "wronghacker@example.com"))
      end
      
      it "should deny access" do
        get :edit, :id => @team.permalink
        response.should redirect_to(root_path)
      end
      
      it "should display a flash message" do
        get :edit, :id => @team.permalink
        flash[:fail].should =~ /You must the creator of this team to edit it/i
      end
    end
    
    describe "for the right users" do
      
      before(:each) do
        test_sign_in(@hacker)
      end
      
      it "should be successful" do
        get :edit, :id => @team.permalink
        response.should be_success
      end
    end
  end
  
  describe "PUT 'update'" do
    before(:each) do
      @hacker = Factory(:hacker)
      @hacker2 = Factory(:hacker, :email => "hacker2@example.com") 
      @team = Factory(:team, :created_by => @hacker.id)
      @team.hackers << @hacker
      @team.save
      @attr = {:name => "Teamname2", :description => "Description 2"}
    end
    
    describe "for non-signed-in users" do
      it "should deny access" do
        put :update, :id => @team.permalink, :team => @attr
        response.should redirect_to(signin_path)
      end
    end
    
    describe "for non-team-members" do
      before(:each) do
        test_sign_in(Factory(:hacker, :email => "wronghacker@example.com"))
      end
      
      it "should deny access" do
        put :update, :id => @team.permalink, :team => @attr
        response.should redirect_to(root_path)
      end
      
      it "should display a flash message" do
        put :update, :id => @team.permalink, :team => @attr
        flash[:fail].should =~ /You must the creator of this team to edit it/i
      end
    end
    
    describe "for the right user" do
      before(:each) do
        test_sign_in(@hacker)
      end
      
      describe "failure" do
        it "should render the edit page" do
          put :update, :id => @team.permalink, :team => @attr.merge(:name => "")
          response.should render_template(:edit)
        end
        
        it "should not update the team" do
          put :update, :id => @team.permalink, :team => @attr.merge(:name => "")
          @team.reload
          @team.name.should_not == ""
        end
      end
      
      describe "success" do
        it "should redirect to the show team page" do
          put :update, :id => @team.permalink, :team => @attr
          @team.reload
          response.should redirect_to(team_path(@team))
        end
        
        it "should update the team" do
          put :update, :id => @team.permalink, :team => @attr
          @team.reload
          @team.name.should == @attr[:name]
        end
      end
    end
  end 
end
