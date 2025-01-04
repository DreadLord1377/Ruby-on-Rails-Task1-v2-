require 'swagger_helper'
require './spec/requests/shared/default_comment_params.rb'

RSpec.configure do |rspec|
  rspec.shared_context_metadata_behavior = :apply_to_host_groups
end

RSpec.shared_context "GET successful response for comment-list", :shared_context => :metadata do

  response(200, 'Successful request') do
    include_context "set default comment params"

    schema '$ref' => '#components/schemas/comment_list'
    run_test!
  end

end

RSpec.configure do |rspec|
  rspec.include_context "GET successful response for comment-list", :include_shared => true
end