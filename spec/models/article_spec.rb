require "rails_helper"

RSpec.describe Article, type: :model do
	it "is valid with valid params" do
		@article = Article.new(title: "Test", body: "Testing...", status: "archived")
		expect(@article).to be_valid
	end

	it "is not valid with not valid title" do
		@article = Article.new(body: "Testing...", status: "public")
		expect(@article).not_to be_valid
	end

	it "is not valid with not valid body" do
		@article = Article.new(title: "Test article", body: "trying", status: "private")
		expect(@article).not_to be_valid
	end

	it "is not valid with not valid status" do
		@article = Article.new(title: "Test article", body: "trying...")
		expect(@article).not_to be_valid
	end

	it "is not valid with not valid params" do
		@article = Article.new(body: "trying", status: "public")
		expect(@article).not_to be_valid
	end
end