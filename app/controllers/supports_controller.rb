class SupportsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @article = Article.find(params[:article_id])
    @support = @user.supports.create(support_params)
    redirect_to article_path(@article)
  end

  private
    def support_params
      params.require(:support).permit(:number)
    end
end
