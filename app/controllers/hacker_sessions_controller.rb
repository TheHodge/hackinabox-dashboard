class HackerSessionsController < ApplicationController

  before_filter :require_no_hacker, :only => [:new, :create]
  before_filter :require_hacker, :only => :destroy

  def new
    @hacker_session = HackerSession.new
    render :layout => "login_layout"
  end

  def create
    @hacker_session = HackerSession.new(params[:hacker_session])
    if @hacker_session.save
      flash[:notice] = "Login successful!"
      redirect_back_or_default edit_profile_path
    else
      render :layout => "login_layout", :action => :new
    end
  end

  def destroy
    current_hacker_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_to root_path
  end
end
