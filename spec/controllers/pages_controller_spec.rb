require 'spec_helper'

describe PagesController do
  
  describe "GET 'home'" do
    
    before(:each) do
      test_sign_in(Factory(:hacker))
    end
    
    it "should be successful" do
      get :home
      response.should be_success 
    end
    
  end

end
