RSpec.configure do |rspec|
  rspec.shared_context_metadata_behavior = :apply_to_host_groups
end

RSpec.shared_context "set default comment params", :shared_context => :metadata do

  default_article_params = { title: 'Article', body: 'Article text', status: 'public' }
  default_comment_params = { commenter: 'Commenter', body: 'Comment text', status: 'public' }

  let!(:article) { Article.create(default_article_params) }
  let!(:article_id) { article.id }
  let!(:comment_1) { article.comments.create(default_comment_params) }
  let!(:comment_2) { article.comments.create(default_comment_params) }
  let!(:comment) { article.comments.create(default_comment_params)}
  let!(:id) { comment.id }
  let!(:page) { 1 }
  let!(:per_page) { 10 }

end

RSpec.configure do |rspec|
  rspec.include_context "set default comment params", :include_shared => true
end