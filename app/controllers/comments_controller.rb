class CommentsController < ApplicationController
  before_action :set_article

  def index
    @comments = @article.comments

    render json: @comments
  end

  def create
    @comment = @article.comments.create(comment_params)
    render json: @comment, status: :created
  end

  def update
    set_comment
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
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
