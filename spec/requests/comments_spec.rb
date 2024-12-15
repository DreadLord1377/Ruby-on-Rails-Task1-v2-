require 'swagger_helper'

RSpec.describe 'comments', type: :request do

  path '/articles/{article_id}/comments' do
    get('list comments') do
      tags 'comment'

      parameter name: :article_id, in: :path, type: :integer, example: 1, required: :true

      produces "application/json"

      after do |example|
        example.metadata[:response][:content] = {
          'application/json' => {
            example: JSON.parse(response.body, symbolize_names: true)
          }
        }
      end

      response(200, 'Successful request') do
        let!(:article) { Article.create(title: 'Article', body: 'Article text', status: 'public') }
        let!(:article_id) { 1 }
        let!(:comment_1) { article.comments.create(commenter: 'Commenter', body: 'Comment text', status: 'public') }
        let!(:comment_2) { article.comments.create(commenter: 'Commenter2', body: 'Comment text2', status: 'public') }
        schema '$ref' => '#components/schemas/comment_list'

        run_test!
      end
    end

    post('create comment') do
      tags 'comment'

      parameter name: :article_id, in: :path, type: :integer, example: 1, required: :true

      consumes "application/json"
      produces "application/json"

      parameter name: :params, in: :body, required: :true, schema: {
        type: :object,
        properties: {
          commenter: { type: :string, example: 'Commenter example' },
          body: { type: :string, example: 'Text example' },
          status: { type: :string, example: 'public' }
        }
      }

      after do |example|
        example.metadata[:response][:content] = {
          'application/json' => {
            example: JSON.parse(response.body, symbolize_names: true)
          }
        }
      end

      response(201, 'Successful request') do
        let!(:article) { Article.create(title: 'Article', body: 'Article text', status: 'public') }
        let!(:article_id) { 1 }
        let!(:params) { { commenter: 'Commenter', body: 'Comment text', status: 'public' } }
        schema '$ref' => '#components/schemas/comment'

        run_test!
      end

      response(404, 'Invalid request (Article id not found)') do
        let!(:article_id) { 1 }
        let!(:params) { { commenter: 'Commenter', body: 'Comment text', status: 'public' } }
        schema '$ref' => '#/components/schemas/error'

        run_test!
      end

      response(422, 'Invalid request (Can not parse given data)') do
        let!(:article) { Article.create(title: 'Article', body: 'Article text', status: 'public') }
        let!(:article_id) { 1 }
        let!(:params) { { commenter: '', body: 'Comment', status: 'public' } }
        schema '$ref' => '#/components/schemas/error'

        run_test!
      end
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

      after do |example|
        example.metadata[:response][:content] = {
          'application/json' => {
            example: JSON.parse(response.body, symbolize_names: true)
          }
        }
      end

      response(200, 'Successful request') do
        let(:article_id) { 1 }
        let(:id) { 1 }
        let(:params) { { commenter: 'Commenter update', body: 'Comment text update', status: 'public' } }
        schema '$ref' => '#components/schemas/comment'

        run_test!
      end

      response(404, 'Invalid request (Article id not found)') do
        let!(:article) { Article.create(title: 'Article', body: 'Article text', status: 'public') }
        let!(:article_id) { 2 }
        let!(:params) { { commenter: 'Commenter', body: 'Comment text', status: 'public' } }
        let(:id) { 1 }
        schema '$ref' => '#/components/schemas/error'

        run_test!
      end

      response(404, 'Invalid request (Comment id not found)') do
        let!(:article) { Article.create(title: 'Article', body: 'Article text', status: 'public') }
        let!(:article_id) { 1 }
        let!(:params) { { commenter: 'Commenter', body: 'Comment text', status: 'public' } }
        let(:id) { 2 }
        schema '$ref' => '#/components/schemas/error'
        
        run_test!
      end

      response(422, 'Invalid request (Can not parse given data)') do
        let!(:article) { Article.create(title: 'Article', body: 'Article text', status: 'public') }
        let!(:article_id) { 1 }
        let!(:params) { { commenter: '', body: 'Comment', status: 'public' } }
        let(:id) { 1 }
        schema '$ref' => '#/components/schemas/error'

        run_test!
      end
    end

    delete('delete comment') do
      tags 'comment'

      parameter name: :article_id, in: :path, type: :integer, example: 1, required: :true
      parameter name: :id, in: :path, type: :integer, example: 1, required: :true

      produces "application/json"

      after do |example|
        example.metadata[:response][:content] = {
          'application/json' => {
            example: JSON.parse(response.body, symbolize_names: true)
          }
        }
      end

      response(204, 'Successful request') do
        let!(:article) { Article.create(title: 'Article', body: 'Article text', status: 'public') }
        let!(:article_id) { 1 }
        let!(:comment) { article.comments.create(commenter: 'Comment', body: 'Comment text', status: 'public') }
        let(:id) { 1 }

        run_test!
      end

      response(404, 'Invalid request (Article id not found)') do
        let!(:article) { Article.create(title: 'Article', body: 'Article text', status: 'public') }
        let!(:article_id) { 2 }
        let!(:comment) { article.comments.create(commenter: 'Comment', body: 'Comment text', status: 'public') }
        let(:id) { 1 }
        schema '$ref' => '#/components/schemas/error'

        run_test!
      end

      response(404, 'Invalid request (Comment id not found)') do
        let!(:article) { Article.create(title: 'Article', body: 'Article text', status: 'public') }
        let!(:article_id) { 1 }
        let!(:comment) { article.comments.create(commenter: 'Comment', body: 'Comment text', status: 'public') }
        let(:id) { 2 }
        schema '$ref' => '#/components/schemas/error'

        run_test!
      end
    end
  end
end
