class SupportsController < ApplicationController
  def create
    #@user = User.find_by_name(session[:current_user]["name"])
    @article = Article.find(params[:article_id])
    @support = @article.supports.create
    
    redirect_to article_path(@article)
  end

  def index
    redirect_to article_path(@article)
  end
end
