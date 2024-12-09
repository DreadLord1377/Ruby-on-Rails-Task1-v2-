require "rails_helper"

RSpec.describe Comment, type: :model do
  it "is valid with valid params" do
    @article = Article.new(title: "Test", body: "Testing...", status: "public")
    @article.save
    @comment = @article.comments.create(commenter: "Developer", body: "Testing comment...", status: "public")
    expect(@comment).to be_valid
  end

  it "is not valid with not valid status" do
    @article = Article.new(title: "Test", body: "Testing...", status: "public")
    @article.save
    @comment = @article.comments.create(commenter: "Developer", body: "Testing comment...")
    expect(@comment).not_to be_valid
  end

  it "is not valid with not valid title" do
    @article = Article.new(title: "Test", body: "Testing...", status: "archived")
    @article.save
    @comment = @article.comments.create(body: "Testing comment...", status: "public")   
    expect(@comment).not_to be_valid
  end

  it "is not valid with not valid body" do
    @article = Article.new(title: "Test", body: "Testing...", status: "private")
    @article.save
    @comment = @article.comments.create(commenter: "Developer", body: "", status: "public")
    expect(@comment).not_to be_valid
  end

  it "is not valid with not valid params" do
    @article = Article.new(title: "Test", body: "Testing...", status: "public")
    @article.save
    @comment = @article.comments.create()
    expect(@comment).not_to be_valid
  end
end