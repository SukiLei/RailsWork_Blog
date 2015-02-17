class UsersController < ApplicationController
=begin
	USER_NAME, PASSWORD = "dhh", "secret"
	#http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :login]
=end
  before_filter :verify_login, except: [:login]
  def verify_login
    @login_stauts = session[:current_user].nil?
  end
  
	def new
		@user = User.new
	end
	def create
		@user = User.new(user_params)

		if @user.save
			@hint = "Regedit OK"
			redirect_to :controller => 'welcome', :action => 'index'
		else
			@hint = "Regedit failed"
			render 'new'
		end
	end

	def login
 		unless request.get?
       	 	@hint = "ok"
        	@user = User.find_by_name(params[:user][:name])
        	if @user.class == NilClass
          		@hint = 'Login faild. Unregisted Username.'
        	elsif @user.password == params[:user][:password]
          		@hint = "Welcome back, "
              session[:current_user] = @user
          		redirect_to :controller => 'home', :action => 'index'
        	else
          	@hint = "Login failed, please check up your account."
        	end
    	end
	end

  def logout
    session[:current_user] = nil
    redirect_to :controller => 'welcome', :action => 'index'
  end

	def show
    @hint_show = @h
		@users = User.find(params[:id])
	end
	def index
		@users = User.all
	end
	private
	def user_params
		params.require(:user).permit(:name, :password)
	end
end
