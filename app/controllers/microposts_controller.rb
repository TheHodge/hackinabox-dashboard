class MicropostsController < ApplicationController

  before_filter :require_hacker

  def create
    @micropost = current_hacker.microposts.build(params[:micropost])
    if @micropost.save
      redirect_to root_path, :flash => {:success => "Post Added"}
    else
      @teams = Team.includes(:hackers).all
      @posts = Micropost.includes(:hackers).all
      render "pages/home"
    end
  end

end
