class FoodsController < ApplicationController

  before_filter :require_hacker
  before_filter :require_admin

  def new
    @food = Food.new
    @current_food = Food.grouped
    @options = Array.new(["Pizza", "Burgers", "Chinese", "Indian"])
  end

  def create
    @food = Food.new(params[:food])
    @options = Array.new(["Pizza", "Burgers", "Chinese", "Indian"])
    if @food.save
      @current_food = Food.grouped
      redirect_to new_food_path, :flash => {:success => "Food has been added"}
    else
      @current_food = Food.grouped
      render :new
    end
  end

  def orders
    @hackers = Hacker.joins(:food).order("foods.name").all
  end

end
