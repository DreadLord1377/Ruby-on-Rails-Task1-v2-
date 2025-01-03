RSpec.configure do |rspec|
  rspec.shared_context_metadata_behavior = :apply_to_host_groups
end

RSpec.shared_context "set default article params", :shared_context => :metadata do

  let!(:article_1) { Article.create(title: 'Article', body: 'Article text', status: 'public') }
  let!(:article_2) { Article.create(title: 'Article', body: 'Article text', status: 'public') }
  let!(:page) { 1 }
  let!(:per_page) { 10 }

end

RSpec.configure do |rspec|
  rspec.include_context "set default article params", :include_shared => true
end