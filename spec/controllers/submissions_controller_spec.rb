require 'spec_helper'

describe SubmissionsController do
  
  render_views
  
  describe "GET 'new'" do
    
    describe "for non-logged-in users" do
      
      it "should deny access" do
        get :new
        response.should redirect_to(signin_path) 
      end
      
    end
    
    describe "for logged-in users" do
      
      before(:each) do
        test_sign_in(Factory(:hacker))
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
      @team = Factory(:team, :hacker_ids => [@hacker.id])
      @category = Factory(:category)
      @attr = { :name => "My Hack",
                :description => "This is a description of my hack",
                :team_id => @team.id,
                :category_ids => [1]
                }
    end
    
    describe "for non-signed-in users" do
      it "should deny access" do
        post :create, :submission => @attr
        response.should redirect_to(signin_path)
      end
      
      it "should not create a submission" do
        lambda do
          post :create, :submission => @attr
        end.should_not change(Submission, :count) 
      end
    end
    
    describe "for signed in users" do
      
      before(:each) do
        test_sign_in(@hacker)
      end
      
      describe "failure" do
        
        it "should render the new page" do
          post :create, :submission => @attr.merge(:name => "", :description => "")
          response.should render_template(:new)
        end
        
        it "should not create a submission " do
          lambda do
            post :create, :submission => @attr.merge(:name => "", :description => "")
          end.should_not change(Submission, :count) 
        end
      end
      
      describe "success" do
        
        it "should redirect to the home page" do
          post :create, :submission => @attr
          response.should redirect_to(submission_path(assigns(:submission)))
        end
        
        it "should create a submission" do
          lambda do
            post :create, :submission => @attr
          end.should change(Submission, :count).by(1)
        end
        
        it "should have a success message" do
          post :create, :submission => @attr
          flash[:success].should =~ /Your Hack has been submitted/i
        end
      end
    end
  end

  describe "GET 'index'" do
    
    describe "for non-signed-in users" do
      it "should deny access" do
        get :index
        response.should redirect_to(signin_path)
      end
    end
    
    describe "for signed-in users" do
      
      before(:each) do
        @hacker = Factory(:hacker)
        test_sign_in(@hacker)
        @team = Factory(:team, :hacker_ids => [@hacker.id])
        @category = Factory(:category)
      end
      
      it "should be successful" do
        get :index
        response.should be_success
        response.should have_selector('title')
      end
      
      it "should list the hackers hacks" do
        submission1 = Factory(:submission, :team => @team, :category_ids => [@category.id]) 
        submission2 = Factory(:submission, :name => "This is another hack", :team => @team, :category_ids => [@category.id])
        get :index
        response.should be_success
        response.should have_selector('td', :content => submission1.name)
        response.should have_selector('td', :content => submission2.name)
      end 
    end
  end

  describe "GET 'show'" do
    
    before(:each) do
      @hacker = Factory(:hacker)
      @team = Factory(:team, :hacker_ids => [@hacker.id])
      @category = Factory(:category)
      @submission = Factory(:submission, :team => @team, :category_ids => [@category.id]) 
    end
    
    describe "for non-signed-in users" do
      it "should deny access" do
        get :show, :id => @submission
        response.should redirect_to(signin_path)
      end
    end
    
    describe "for non-team-members" do
      before(:each) do
        test_sign_in(Factory(:hacker, :email => "wrong_hacker@example.com"))
      end
      
      it "should deny access" do
        get :show, :id => @submission
        response.should redirect_to(root_path)
      end
      
      it "should display a flash message" do
        get :show, :id => @submission
        flash[:notice].should =~ /You must be on the team to view\/edit this Hack/i
      end
    end
        
    describe "for team members" do
      before(:each) do
        test_sign_in(@hacker)
      end
      
      it "should be successful" do
        get :show, :id => @submission
        response.should be_success
      end
    end
  end

  describe "GET 'edit'" do
    
    before(:each) do
      @hacker = Factory(:hacker)
      @team = Factory(:team, :hacker_ids => [@hacker.id])
      @category = Factory(:category)
      @submission = Factory(:submission, :team => @team, :category_ids => [@category.id]) 
    end

    describe "for non-signed-in users" do
      it "should deny access" do
        get :edit, :id => @submission
        response.should redirect_to(signin_path)
      end
    end

    describe "for non-team-members" do
      before(:each) do
        test_sign_in(Factory(:hacker, :email => "wrong_hacker@example.com"))
      end

      it "should deny access" do
        get :edit, :id => @submission
        response.should redirect_to(root_path)
      end

      it "should display a flash message" do
        get :edit, :id => @submission
        flash[:notice].should =~ /You must be on the team to view\/edit this Hack/i
      end
    end

    describe "for team members" do
      before(:each) do
        test_sign_in(@hacker)
      end

      it "should be successful" do
        get :edit, :id => @submission
        response.should be_success
      end
    end
  end
  
  describe "PUT 'update'" do
    before(:each) do
      @hacker = Factory(:hacker)
      @team = Factory(:team, :hacker_ids => [@hacker.id])
      @category = Factory(:category)
      @submission = Factory(:submission, :team => @team, :category_ids => [@category.id])
      @attr = {:name => "This is a better hack name", :description => "This is a better hack description"} 
    end

    describe "for non-signed-in users" do
      it "should deny access" do
        put :update, :id => @submission, :submission => @attr
        response.should redirect_to(signin_path)
      end
    end

    describe "for non-team-members" do
      before(:each) do
        test_sign_in(Factory(:hacker, :email => "wrong_hacker@example.com"))
      end

      it "should deny access" do
        put :update, :id => @submission, :submission => @attr
        response.should redirect_to(root_path)
      end

      it "should display a flash message" do
        put :update, :id => @submission, :submission => @attr
        flash[:notice].should =~ /You must be on the team to view\/edit this Hack/i
      end
    end

    describe "for team members" do
        before(:each) do
          test_sign_in(@hacker)
        end
        
        describe "failure" do
          it "should render the edit page" do
            put :update, :id => @submission, :submission => @attr.merge(:name => "")
            response.should render_template(:edit)
          end
          
          it "should not change the hack" do
            put :update, :id => @submission, :submission => @attr.merge(:name => "")
            @submission.reload
            @submission.description.should_not == @attr[:description]
          end
        end
          
        describe "success" do
          it "should redirect to the show page" do
            put :update, :id => @submission, :submission => @attr
            response.should redirect_to(submission_path(@submission))
          end
          
          it "should change the submissions attributes" do
            put :update, :id => @submission, :submission => @attr
            @submission.reload
            @submission.name.should == @attr[:name]
            @submission.description.should == @attr[:description]
          end
        end
      end
  end
end
