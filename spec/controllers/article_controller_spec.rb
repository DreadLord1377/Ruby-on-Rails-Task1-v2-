require "rails_helper"

RSpec.describe ArticlesController, type: :request do
	describe "GET /articles" do
		it "GET (home) respond is ok" do
			get articles_path

			expect(response).to have_http_status :ok
		end
	end

	describe "GET /articles/:id" do
		it "GET (id) respond is ok" do
			@article = Article.new(title: "Test", body: "Testing...", status: "public")
			@article.save

			get article_path(@article.id)

			expect(response).to have_http_status :ok
		end

		it "GET (id) respond: id doesn't exist" do
			article_id = 1

			get article_path(article_id)

			expect(response).to have_http_status :not_found
		end
	end

	describe "POST /articles" do
		it "POST respond is ok" do
			article_params = {article: { title: "Test", body: "Testing...", status: "archived" } }

			post articles_path, params: article_params

			expect(response).to have_http_status :created
		end
	end

	describe "PATCH /articles/:id" do
		it "PATCH respond is ok" do
			@article = Article.new(title: "Test", body: "Testing...", status: "archived")
			@article.save
			article_params = {article: { title: "Test2", status: "public" } }

			patch article_path(@article.id), params: article_params

			expect(response).to have_http_status :ok
		end

		it "PATCH respond: id doesn't exist" do
			article_id = 1
			article_params = {article: { title: "Test2", status: "public" } }

			patch article_path(article_id), params: article_params

			expect(response).to have_http_status :not_found
		end
	end

	describe "DELETE /articles/:id" do
		it "DELETE respond is ok" do
			@article = Article.new(title: "Test", body: "Testing...", status: "private")
			@article.save

			delete article_path(@article.id)

			expect(response).to have_http_status :no_content
		end

		it "DELETE respond: id doesn't exist" do
			article_id = 1
			
			delete article_path(article_id)

			expect(response).to have_http_status :not_found
		end
	end
end