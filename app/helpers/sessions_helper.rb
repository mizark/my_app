module SessionsHelper

	def sign_in(user)
		#Sign the user in
		cookies.permanent[:remember_token] = user.remember_token
		self.current_user = user

	end

	def signed_in?
		!current_user.nil?
	end

	def current_user=(user)
		@current_user = user

	end

	def current_user
		@current_user = @current_user || User.find_by_remember_token(cookies[:remember_token])
	end

	def current_user?(user)
		user == current_user
	end

	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end

	def store_location
		#session is like a cookie but expires on browswer close
		session[:return_to] = request.fullpath

	end

	def redirect_back_or(default)

		# if return_to key doesn't exist, will redirect to default
		redirect_to(session[:return_to] || default )
		session.delete(:return_to)
	end


end
