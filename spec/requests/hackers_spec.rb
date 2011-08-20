require 'spec_helper'

describe "Hackers" do
  
  describe "signup" do
    
    describe "failure" do
      
      it "should not make a new user" do
        lambda do
          visit signup_path
          fill_in "Email",        :with => ""
          fill_in "Password",     :with => ""
          fill_in "Confirm Password", :with => ""
          click_button
        response.should render_template("hackers/new")
        end.should_not change(Hacker, :count)
      end
    end
    
    describe "success" do
      
      it "should not make a new user" do
        lambda do
          visit signup_path
          fill_in "Email",        :with => "example@exapmle.com"
          fill_in "Password",     :with => "foobar"
          fill_in "Confirm Password", :with => "foobar"
          click_button
        response.should render_template("hackers/edit")
        end.should change(Hacker, :count).by(1)
      end
    end
  end
  
  describe "signin" do
      
    describe "failure" do
      it "should not sign a user in" do
        visit signin_path
        fill_in "Email",    :with => ""
        fill_in "Password", :with => ""
        click_button
        response.should render_template('hacker_sessions/new')
      end
    end

    describe "success" do
      it "should sign a user in and out" do
        user = Factory(:hacker)
        visit signin_path
        fill_in "Email",    :with => user.email
        fill_in "Password", :with => user.password
        click_button
        controller.should be_signed_in
        click_link "Sign out"
        controller.should_not be_signed_in
      end
    end
  end
end
          