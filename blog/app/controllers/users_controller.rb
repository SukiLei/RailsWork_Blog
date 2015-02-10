class UsersController < ApplicationController
=begin
	USER_NAME, PASSWORD = "dhh", "secret"  
	#http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :login]
=end
  before_filter :verify_login, except: [:login]
  def verify_login
    @login_stauts = session[:current_user].nil?
    #puts "=====================\n#{@login_stauts}\n====================="
  end
=begin
	before_filter :verify_access, except: [:index, :login]
	def verify_access
    if session[:current_user].nil?
      authenticate_or_request_with_http_basic do |name, passwd|
        t = User.find_by_name(name)
        (t.nil?) ? false : ((passwd == t.password) ? true : false )
      end
    end
	end
=end
	def new
		@user = User.new
	end
	def create
		@user = User.new(user_params)
		@h = '0.0'

		if @user.save
			redirect_to @user
			@h = "Regedit OK"
		else
			render 'new'
			@h = "Regedit failed"
		end
	end
	def login
 		unless request.get?
       	 	@hint = "ok"
        	@user = User.find_by_name(params[:user][:name])
        	if @user.class == NilClass
          		@hint = 'Unregisted Username.'
        	elsif @user.password == params[:user][:password]
          		@hint = "Welcome back, "
              session[:current_user] = @user
          		redirect_to :controller => 'users', :action => 'index'
        	else
          	@hint = "Login failed, please check up you info"
        	end        
    	end	
	end

  def logout
    session[:current_user] = nil
    puts "=====================\n#{session[:current_user].class}\n====================="
    redirect_to :controller => 'welcome', :action => 'index'
  end

	def show
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
