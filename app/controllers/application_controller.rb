class ApplicationController < ActionController::Base
  protect_from_forgery

  include HackerSessionsHelper
  include HackersHelper

  def require_admin
    if (!current_hacker.admin?)
      flash[:fail] = "You must be an admin to access this page"
      redirect_to(root_path)
    end 
  end

end
