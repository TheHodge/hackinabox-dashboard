class CommitsController < ApplicationController

  def create
    @user = Hacker.find_by_id(params[:user])

    if @user.single_access_token == params[:secret]
      @commit = Commit.new
      @commit.message = params[:message]
      @commit.files = params[:files]
      @commit.user_id = @user.id
      @commit.save

      @pusher = YAML::load(File.open("#{RAILS_ROOT}/config/pusher.yml"))

      Pusher.app_id = @pusher['app_id']
      Pusher.key = @pusher['key']
      Pusher.secret = @pusher['secret']

      Pusher['main'].trigger!('commit', {:message => CGI.escapeHTML(params[:message].to_s),:user => @user.id })
    end

    render :layout => "blank"
  end

end
