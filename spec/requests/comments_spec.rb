require 'swagger_helper'
require './spec/requests/shared/show_json.rb'
require './spec/requests/shared/show_json_by_id.rb'
require './spec/requests/shared/default_comment_params'
require './spec/requests/shared/get_successful_comment-list_response.rb'

RSpec.describe 'comments', type: :request do

  path '/articles/{article_id}/comments' do
    get('list comments (first 10)') do
      tags 'comment'

      produces "application/json"

      parameter name: :article_id, in: :path, type: :integer, example: 1, required: :true

      include_context "show json"

      include_context "GET successful response for comment-list"
    end

    post('create comment') do
      tags 'comment'

      consumes "application/json"
      produces "application/json"

      parameter name: :article_id, in: :path, type: :integer, example: 1, required: :true

      parameter name: :params, in: :body, required: :true, schema: {
        type: :object,
        properties: {
          commenter: { type: :string, example: 'Commenter example' },
          body: { type: :string, example: 'Text example' },
          status: { type: :string, example: 'public' }
        }
      }

      include_context "show json by id"

      response(201, 'Successful request') do
        include_context "set default comment params"

        let!(:params) { { commenter: 'Commenter', body: 'Comment text', status: 'public' } }
        schema '$ref' => '#components/schemas/comment'

        run_test!
      end

      response(404, 'Invalid request (Article id not found)') do
        include_context "set default comment params" do
          let!(:article_id) { 4534654 }
        end

        let!(:params) { { commenter: 'Commenter', body: 'Comment text', status: 'public' } }

        run_test!
      end

      response(422, 'Invalid request (Can not parse given data)') do
        include_context "set default comment params"

        let!(:params) { { commenter: '', body: 'Comment', status: 'public' } }
        schema '$ref' => '#/components/schemas/error'

        run_test!
      end
    end
  end

  path '/articles/{article_id}/comments?page={page}' do
    get('list only necessary comments') do
      tags 'comment'

      parameter name: :article_id, in: :path, type: :integer, example: 1, required: :true
      parameter name: :page, in: :path, type: :integer, example: 1, required: :true

      produces "application/json"

      include_context "show json"

      include_context "GET successful response for comment-list"
    end
  end

  path '/articles/{article_id}/comments?page={page}&per_page={per_page}' do
    get('list only necessary comments') do
      tags 'comment'

      parameter name: :article_id, in: :path, type: :integer, example: 1, required: :true
      parameter name: :page, in: :path, type: :integer, example: 1, required: :true
      parameter name: :per_page, in: :path, type: :integer, example: 10, required: :true

      produces "application/json"

      include_context "show json"

      include_context "GET successful response for comment-list"
    end
  end

  path '/articles/{article_id}/comments/{id}' do
    patch('update comment') do
      tags 'comment'

      parameter name: :article_id, in: :path, type: :integer, example: 1, required: :true
      parameter name: :id, in: :path, type: :integer, example: 1, required: :true

      consumes "application/json"
      produces "application/json"

      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          commenter: { type: :string, example: 'Commenter example update' },
          body: { type: :string, example: 'Text example update' },
          status: { type: :string, example: 'private' }
        }
      }

      include_context "show json by id"

      response(200, 'Successful request') do
        include_context "set default comment params"

        let!(:params) { { commenter: 'Commenter update', body: 'Comment text update', status: 'public' } }

        schema '$ref' => '#components/schemas/comment'

        run_test!
      end

      response(404, 'Invalid request (Article id not found)') do
        include_context "set default comment params" do
          let!(:article_id) { 4534654 }
        end

        let!(:params) { { commenter: 'Commenter update', body: 'Comment text update', status: 'public' } }

        run_test!
      end

      response(404, 'Invalid request (Comment id not found)') do
        include_context "set default comment params" do
          let!(:id) { 4534654 }
        end

        let!(:params) { { commenter: 'Commenter', body: 'Comment text', status: 'public' } }
        
        run_test!
      end

      response(422, 'Invalid request (Can not parse given data)') do
        include_context "set default comment params"

        let!(:params) { { commenter: '', body: 'Comment', status: 'public' } }
        
        schema '$ref' => '#/components/schemas/error'

        run_test!
      end
    end

    delete('delete comment') do
      tags 'comment'

      parameter name: :article_id, in: :path, type: :integer, example: 1, required: :true
      parameter name: :id, in: :path, type: :integer, example: 1, required: :true

      produces "application/json"

      include_context "show json by id"

      response(204, 'Successful request') do
        include_context "set default comment params"

        run_test!
      end

      response(404, 'Invalid request (Article id not found)') do
        include_context "set default comment params" do
          let!(:article_id) { 4534654 }
        end

        run_test!
      end

      response(404, 'Invalid request (Comment id not found)') do
        include_context "set default comment params" do
          let!(:id) { 4534654 }
        end

        run_test!
      end
    end
  end
end
