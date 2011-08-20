class TeamsController < ApplicationController

  before_filter :require_hacker
  before_filter :require_creator, :only => [:edit, :update]

  def new
    @team = Team.new
  end

  def create 
    @team = Team.new(params[:team].merge(:hacker_ids => [current_hacker.id], :created_by => current_hacker.id))
    if @team.save
      redirect_to @team
    else
      render :new
    end
  end

  def show 
    @team = Team.includes(:hackers).find_by_permalink(params[:id])
  end

  def index
    @teams = Team.all
  end

  def edit
    @team = Team.includes(:hackers).find_by_permalink(params[:id])
  end

  def update 
    @team = Team.includes(:hackers).find_by_permalink(params[:id])
    if @team.update_attributes(params[:team])
      redirect_to team_path(@team)
    else
      render :edit
    end
  end

  def join
    @team = Team.includes(:hackers).find_by_permalink(params[:id])
    if (!@team.hackers.include?(current_hacker) && @team.hackers.count.to_i < 4)
      @team.hackers << current_hacker
      if @team.save
        redirect_to team_path(@team), :flash => {:success => "You have been added to this team"}
      else
        redirect_to team_path(@team), :flash => {:fail => "You could not be added to this team"}
      end
    else
      redirect_to team_path(@team), :flash => {:fail => "You could not be added to this team, teams cannot have more than four members and you can only add yourself to a team once."}
    end
  end

private

  def require_creator
    team = Team.includes(:hackers).find_by_permalink(params[:id])
    unless team.created_by == current_hacker.id
      flash[:fail] = "You must the creator of this team to edit it."
      redirect_to root_path
      return false
    end
  end

end
