class ArticlesController < ApplicationController
  
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    @articles = Article.all

    render json: @articles
  end

  def show
    set_article
    render json: @article
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      render json: @article, status: :created
    else
      render json: { error: '422: Invalid request (Can not parse given data)', details: @article.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    set_article
    if @article.update(article_params)
      render json: @article
    else
      render json: { error: '422: Invalid request (Can not parse given data)', details: @article.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    set_article
    @article.destroy
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.expect(article: [ :title, :body, :status ])
    end

    def not_found
      head 404
    end
end
