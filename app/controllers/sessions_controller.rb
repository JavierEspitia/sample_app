class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      reset_session #metodo de rails
      log_in user #metodo del helper
      params[:session][:remember_me] == '1' ? remember(user) : forget(user) #metodos del helper
      session[:session_token] = user.session_token
      redirect_to user_url(user)
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
    log_out if logged_in? #llama a log out si se esta conectado
    redirect_to root_url
  end

end
