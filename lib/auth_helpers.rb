helpers do
  def login_required
    if session[:user]
      return true
    elsif request.env['REQUEST_PATH'] =~ /(\.json|\.xml)$/ && request.env['HTTP_USER_AGENT'] !~ /Mozilla/
        @auth ||= Rack::Auth::Basic::Request.new(request.env)
        if @auth.provided? && @auth.basic? && @auth.credentials && User.authenticate(@auth.credentials.first, @auth.credentials.last)
          session[:user] = User.first(:username => @auth.credentials.first).id
          return true
        else
          status 401
          halt("401 Unauthorized") rescue throw(:halt, "401 Unauthorized")
        end
    else
      session[:return_to] = request.fullpath
      redirect '/login'
      pass rescue throw :pass
    end
  end
  
  def admin_required
    return true if login_required && current_user.access <= 0
    redirect '/'
  end
    
  def current_user
    User.get(session[:user])
  end
    
  def redirect_to_stored
    if return_to = session[:return_to]
      session[:return_to] = nil
      redirect return_to
    else
      redirect '/write'
    end
  end
end