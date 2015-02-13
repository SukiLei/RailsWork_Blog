class ArticlesController < ApplicationController
	before_filter :verify_access, except: [:index]
	def verify_access
    if session[:current_user].nil?
      @hint = "Verify access failed, log in first please."
      redirect_to :controller => 'users', :action => 'login'
=begin
      authenticate_or_request_with_http_basic do |name, passwd|
        t = User.find_by_name(name)
        login_status = (t.nil?) ? false : ((passwd == t.password) ? true : false )
        if login_status
          session[:current_user] = t
          return true
        else
          @hint = "User name or Password is not right."
          return false
        end
      end
=end
    else
      #username = User.find_by_name(session[:current_user]["name"])
    end
	end

	def new
		@article = Article.new
	end

	def create
		#render plain: params[:article].inspect
		@article = Article.new(article_params)

		if @article.save
			redirect_to @article
		else
			render 'new'
		end
	end

	def edit
		@article = Article.find(params[:id])
	end

	def update
		@article = Article.find(params[:id])

	    if @article.update(article_params)
		    redirect_to @article
  	    else
    		render 'edit'
  		end
	end

	def show
		@article = Article.find(params[:id])
	end

	def destroy
	  @article = Article.find(params[:id])
 	  @article.destroy

  	  redirect_to articles_path
	end

	def index
		@articles = Article.all
	end

  def add_support
    @support = Support.new
    @user = session[:current_user]
    puts "============\n#{params[:id]}\n============"
    @article = Article.find(params[:id])
    puts "============\n#{@article.class}\n============"
    @support = @article.supports.create(support_params)

    if @support.save
			redirect_to @article
		else
			render 'new'
		end
    redirect_to article_path(@article)
  end

	private
	def article_params
		params.require(:article).permit(:title, :text, :picture)
	end
end
