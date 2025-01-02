class CommentsController < ApplicationController

  before_action :set_article

  def index
    @comments = @article.comments

    render json: @comments.then(&paginate)
  end

  def create
    @comment = @article.comments.create(comment_params)

    if @comment.save
      render json: @comment, status: :created
    else
      render json: { error: '422: Invalid request (Can not parse given data)', details: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end    

  def update
    set_comment
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: { error: '422: Invalid request (Can not parse given data)', details: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    set_comment
    @comment.destroy
  end

  private
    def set_article
      @article = Article.find(params[:article_id])
    end

    def set_comment
      @comment = @article.comments.find(params[:id])
    end

    def comment_params
      params.expect(comment: [ :commenter, :body, :status ])
    end
end
