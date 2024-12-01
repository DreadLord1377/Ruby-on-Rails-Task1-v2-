require "rails_helper"

RSpec.describe CommentsController, type: :request do
	describe "GET /articles/:id/comments" do
		it "GET (all) respond is ok" do
			new_article
			get "/articles/1/comments"

			expect(response).to have_http_status :ok
		end
	end

	describe "POST /articles/:id/comments" do
		it "POST respond is ok" do
			new_article
			comment_params = {comment: { commenter: "Test comment", body: "comment", status: "public" } }

			post "/articles/1/comments/", params: comment_params

			expect(response).to have_http_status :created
		end
	end

	describe "PATCH /articles/:id/comments/:id" do
		it "PATCH respond is ok" do
			new_article
			@comment = @article.comments.create(id: 1, commenter: "Test comment", body: "comment", status: "public")
			comment_params = {comment: { commenter: "Test comment2" } }

			patch "/articles/1/comments/1", params: comment_params

			expect(response).to have_http_status :ok
		end

		it "PATCH respond: id doesn't exist" do
			new_article
			comment_params = {comment: { commenter: "Test comment2" } }

			patch "/articles/1/comments/1", params: comment_params

			expect(response).to have_http_status :not_found
		end
	end

	describe "DELETE /articles/:id/comments/:id" do
		it "DELETE respond is ok" do
			new_article
			@comment = @article.comments.create(id: 1, commenter: "Test comment", body: "comment", status: "archived")

			delete "/articles/1/comments/1"

			expect(response).to have_http_status :no_content
		end

		it "DELETE respond: id doesn't exist" do
			new_article

			delete "/articles/1/comments/1"

			expect(response).to have_http_status :not_found
		end
	end
end

private
	def new_article
		@article = Article.new(id: 1, title: "Test", body: "Testing...", status: "public")
		@article.save
	end