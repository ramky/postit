class SessionsController < ApplicationController

	def new; end

	def create
		user = User.find_by(username: params[:username])
		if user && user.authenticate(params[:password])
		  session[:two_factor] = true
		  if user.two_factor_auth?
		    user.generate_pin!
		    user.send_pin_to_twilio
		    redirect_to pin_path
	    else
			  login_user!(user)
		  end
		else
			flash[:error] = 'Invalid username or password'
			redirect_to login_path
		end
	end
	
	def pin
	  access_denied("Authentication failed!") unless session[:two_factor] == true
	  if request.post?
	    user = User.find_by pin: params[:pin]
	    if user
	      session[:two_factor] = nil
	      login_user!(user)
      else
        flash[:error] = 'Incorrect Pin.'
  			redirect_to login_path
      end
    end
  end

	def destroy
		session[:user_id] = nil
		flash[:notice] = "You've logged out!"
		redirect_to root_path
	end
	
private
  def login_user!(user)
    session[:user_id] = user.id
    user.remove_pin!
    redirect_to root_path
  end
end