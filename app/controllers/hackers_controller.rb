class HackersController < ApplicationController

  before_filter :require_no_hacker, :only => [:new, :create]
  before_filter :require_hacker, :only => [:show, :edit, :update, :food]

  def new
    @hacker = Hacker.new
    render :layout => "login_layout"
  end

  def create
    @hacker = Hacker.new(params[:hacker])
    if @hacker.save
      redirect_to edit_profile_path, :flash => {:success => "Welcome"}
    else
      render :layout => "login_layout", :action => :new
    end
  end

  def edit
    @hacker = @current_hacker
    store_location
  end

  def food
    @options = Array.new(["Pizza", "Burgers", "Chinese", "Indian"])
    @current_food = Food.grouped
    @hacker = @current_hacker
    store_location
  end

  def source
  end

  def download

    string = "

    #!/bin/sh
    #
    # An example hook script that is called after a successful
    # commit is made.
    #
    # To enable this hook, rename this file to \"post-commit\".


    curl -d \"output=`git show  --format='git&message=%s&user=#{current_hacker.id}&secret=#{current_hacker.single_access_token}&files='  --name-only HEAD`\"  http://www.hackinabox.org/commits/"

    file = ''
    file << string
    send_data file, :filename => "post-commit"
  end

  def update
    @hacker = @current_hacker
    if @hacker.update_attributes(params[:hacker])
      flash[:success] = "Your details have been updated"
      redirect_back_or_default(root_path)
    else
      render :edit
    end
  end

end
