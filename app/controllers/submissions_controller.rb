class SubmissionsController < ApplicationController

  before_filter :require_hacker
  before_filter :require_member, :except => [:new, :create, :index, :full_list]
  before_filter :require_admin, :only => [:full_list]

  def new
    @categories = Category.all
    @submission = Submission.new
  end

  def create
    @submission = Submission.new(params[:submission])
    if @submission.save
      redirect_to submission_path(@submission), :flash => {:success => "Your Hack has been submitted"}
    else
      render :new
    end
  end

  def index
    @teams = current_hacker.teams
  end

  def show
    @submission = Submission.includes(:categories).find_by_id(params[:id])
  end

  def edit
    @submission = Submission.includes(:categories).find_by_id(params[:id])
  end

  def update
    @submission = Submission.find_by_id(params[:id])
    if @submission.update_attributes(params[:submission])
      redirect_to submission_path(@submission)
    else
      render(:edit)
    end
  end

  def full_list
    @submissions = Submission.includes(:categories, :team).all
  end

private

  def require_member
    submission = Submission.find_by_id(params[:id])
    unless current_hacker.teams.to_ary.include?(submission.team) || current_hacker.admin?
      flash[:notice] = "You must be on the team to view/edit this Hack."
      redirect_to root_path
      return false
    end
  end

end
