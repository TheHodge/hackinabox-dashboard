class CategoriesController < ApplicationController

  before_filter :require_hacker
  before_filter :require_admin, :only => [:new, :create]

  def new
    @categories = Category.all
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    @categories = Category.all
    if @category.save
      @categories = Category.all
      redirect_to new_category_path
    else
      render :new
    end
  end

end
