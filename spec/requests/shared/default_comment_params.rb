RSpec.configure do |rspec|
  rspec.shared_context_metadata_behavior = :apply_to_host_groups
end

RSpec.shared_context "set default comment params", :shared_context => :metadata do

  let!(:article) { Article.create(title: 'Article', body: 'Article text', status: 'public') }
  let!(:article_id) { article.id }
  let!(:comment_1) { article.comments.create(commenter: 'Commenter', body: 'Comment text', status: 'public') }
  let!(:comment_2) { article.comments.create(commenter: 'Commenter2', body: 'Comment text2', status: 'public') }
  let!(:page) { 1 }
  let!(:per_page) { 10 }

end

RSpec.configure do |rspec|
  rspec.include_context "set default comment params", :include_shared => true
end