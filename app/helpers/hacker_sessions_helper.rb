module HackerSessionsHelper
  
  def signed_in?
    !current_hacker.nil?
  end
  
  private
    def current_hacker_session
      return @current_hacker_session if defined?(@current_hacker_session)
      @current_hacker_session = HackerSession.find
    end

    def current_hacker
      return @current_hacker if defined?(@current_hacker)
      @current_hacker = current_hacker_session && current_hacker_session.hacker
    end
    
    def require_hacker
      unless current_hacker
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to signin_path
        return false
      end
    end

    def require_no_hacker
      if current_hacker
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to root_path
        return false
      end
    end
    
    def store_location
      session[:return_to] = request.fullpath
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
  
end
