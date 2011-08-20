class PagesController < ApplicationController

  before_filter :require_hacker

  def home
    @teams = Team.includes(:hackers).all
    @micropost = Micropost.new
    @posts = Micropost.includes(:hacker).page(params[:page]).per(10)
  end

end
