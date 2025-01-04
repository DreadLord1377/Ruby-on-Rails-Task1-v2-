require 'swagger_helper'
require './spec/requests/shared/show_json.rb'
require './spec/requests/shared/show_json_by_id.rb'
require './spec/requests/shared/default_article_params.rb'
require './spec/requests/shared/get_successful_article-list_response.rb'

RSpec.describe 'articles', type: :request do

  path '/' do
    get('list articles (first 10)') do
      tags 'article'

      produces "application/json"
      include_context "show json"

      include_context "GET successful response for article-list"
    end
  end

  path '/?page={page}' do
    get('list only necessary articles') do
      tags 'article'

      produces "application/json"

      parameter name: :page, in: :path, type: :integer, example: 1, required: :true

      include_context "show json"

      include_context "GET successful response for article-list"
    end
  end

  path '/?page={page}&per_page={per_page}' do
    get('list only necessary articles') do
      tags 'article'

      produces "application/json"

      parameter name: :page, in: :path, type: :integer, example: 1, required: :true
      parameter name: :per_page, in: :path, type: :integer, example: 10, required: :true

      include_context "show json"

      include_context "GET successful response for article-list"
    end
  end

  path '/articles' do
    get('list articles (first 10)') do
      tags 'article'

      produces "application/json"
      include_context "show json"

      include_context "GET successful response for article-list"
    end

    post('create article') do
      tags 'article'

      consumes "application/json"
      produces "application/json"

      parameter name: :params, in: :body, required: :true, schema: {
        type: :object,
        properties: {
          title: { type: :string, example: 'Title example' },
          body: { type: :string, example: 'Text example' },
          status: { type: :string, example: 'public' }
        }
      }

      include_context "show json"

      response(201, 'Successful request') do
        let!(:params) { { title: 'Article', body: 'Article text', status: 'public' } }

        schema '$ref' => '#components/schemas/article_show'
        run_test!
      end

      response(422, 'Invalid request (Can not parse given data)') do
        let!(:params) { { title: '', body: 'Article', status: 'public' } }

        schema '$ref' => '#/components/schemas/error'
        run_test!
      end
    end
  end

  path '/articles/?page={page}' do
    get('list only necessary articles') do
      tags 'article'

      produces "application/json"

      parameter name: :page, in: :path, type: :integer, example: 1, required: :true

      include_context "show json"

      include_context "GET successful response for article-list"
    end
  end

  path '/articles/?page={page}&per_page={per_page}' do
    get('list only necessary articles') do
      tags 'article'

      produces "application/json"

      parameter name: :page, in: :path, type: :integer, example: 1, required: :true
      parameter name: :per_page, in: :path, type: :integer, example: 10, required: :true

      include_context "show json"

      include_context "GET successful response for article-list"
    end
  end

  path '/articles/{id}' do

    get('show article') do
      tags 'article'

      produces "application/json"

      parameter name: :id, in: :path, type: :integer, example: 1, required: :true

      include_context "show json by id"

      response(200, 'Successful request') do
        include_context "set default article params"

        schema '$ref' => '#components/schemas/article_show'
        run_test!
      end

      response(404, 'Invalid request (Id not found)') do
        let!(:id) { 4534654 }

        run_test!
      end
    end

    patch('update article') do
      tags 'article'

      parameter name: :id, in: :path, type: :integer, example: 1, required: :true

      consumes "application/json"
      produces "application/json"

      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string, example: 'Title example update' },
          body: { type: :string, example: 'Text example update' },
          status: { type: :string, example: 'private' }
        }
      }   

      include_context "show json by id"

      response(200, 'Successful request') do
        include_context "set default article params"

        let!(:params) { { title: 'Article update', body: 'Article text update', status: 'public' } }

        schema '$ref' => '#components/schemas/article_show'
        run_test!
      end

      response(404, 'Invalid request (Id not found)') do
        let!(:params) { { title: 'Article update', body: 'Article text update', status: 'public' } }
        let!(:id) { 4534654 }

        run_test!
      end
      
      response(422, 'Invalid request (Can not parse given data)') do
        include_context "set default article params"
        
        let!(:params) { { title: '', body: 'update', status: 'public' } }

        schema '$ref' => '#/components/schemas/error'
        run_test!
      end
    end

    delete('delete article') do
      tags 'article'

      produces "application/json"

      parameter name: :id, in: :path, type: :integer, example: 1, required: :true

      include_context "show json by id"

      response(204, 'Successful request') do
        include_context "set default article params"

        run_test!
      end

      response(404, 'Invalid request (Id not found)') do
        let!(:id) { 4534654 }

        run_test!
      end
    end
  end
end
