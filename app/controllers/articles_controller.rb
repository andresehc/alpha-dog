class ArticlesController < ApplicationController
  before_action :set_article,only:[:edit, :update, :show, :destroy]
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    # render plain: params[:article].inspect
    # @article.save
    @article = Article.new (article_params)
    if @article.save
      flash[:notice] = "Article was succesfully created"
      redirect_to article_path(@article)
    else
      render 'new'
    end

    
  end

  def show

    @article = Article.find(params[:id])

  end

  def edit

    @article = Article.find(params[:id])

  end


  def destroy

    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = "The article was eliminated succesfully"
    redirect_to articles_path

  end
  
  def update

    @article = Article.find(params[:id])  
    if @article.update(article_params)
      flash[:notice] = "Article was successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end 

  private
  def set_article

    @article = Article.find(params[:id])

  end

  def article_params
    params.required(:article).permit(:title, :description)
  end
end