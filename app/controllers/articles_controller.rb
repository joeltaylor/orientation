class ArticlesController < ApplicationController
  before_filter :authenticate_user!, except: [:index]
  respond_to :html, :json

  def index
    @articles = Article.search(params[:search])
  end

  def show
    respond_with @article = ArticleDecorator.new(find_article_by_params)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.author = current_user
    redirect_to @article if @article.save
  end

  def edit
    @article = find_article_by_params
    @tags = @article.tags.collect{ |t| Hash["id" => t.id, "name" => t.name] }
  end

  def update
    @article = find_article_by_params
    @article.author = @article.author || current_user
    redirect_to @article if @article.update_attributes(article_params)
  end

  def destroy
    @article = find_article_by_params
    redirect_to articles_url if @article.destroy
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :tag_tokens)
  end

  def find_article_by_params
    Article.find(params[:id])
  end
end
