require 'swagger_helper'

RSpec.describe 'articles', type: :request do

  path '/' do
    get('list articles') do
      tags 'article'

      produces "application/json"

      after do |example|
        example.metadata[:response][:content] = {
          'application/json' => {
            example: JSON.parse(response.body, symbolize_names: true)
          }
        }
      end

      response(200, 'Successful request') do
        let!(:article_1) { Article.create(title: 'Article', body: 'Article text', status: 'public') }
        let!(:article_2) { Article.create(title: 'Article', body: 'Article text', status: 'public') }

        schema '$ref' => '#components/schemas/article_show_list'

        #after do |example|
          #content = example.metadata[:response][:content] || {}
          #example_spec = {
            #{}"application/json"=>{
              #examples: {
                #test_example: {
                  #value: JSON.parse(response.body, symbolize_names: true)
                #}
              #}
            #}
          #}
          #example.metadata[:response][:content] = content.deep_merge(example_spec)
        #end

        #after(:each, operation: true, use_as_request_example: true) do |spec|
          #spec.metadata[:operation][:request_examples] ||= []

          #example = {
            #value: JSON.parse(request.body.string, symbolize_names: true),
            #name: 'request_example_1',
            #summary: 'A request example'
          #}

          #spec.metadata[:operation][:request_examples] << example
        #end

        run_test!
      end
    end
  end

  path '/articles' do
    get('list articles') do
      tags 'article'

      produces "application/json"

      after do |example|
        example.metadata[:response][:content] = {
          'application/json' => {
            example: JSON.parse(response.body, symbolize_names: true)
          }
        }
      end

      response(200, 'Successful request') do
        let!(:article_1) { Article.create(title: 'Article', body: 'Article text', status: 'public') }
        let!(:article_2) { Article.create(title: 'Article', body: 'Article text', status: 'public') }

        schema '$ref' => '#components/schemas/article_show_list'

        run_test!
      end
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

      after do |example|
        example.metadata[:response][:content] = {
          'application/json' => {
            example: JSON.parse(response.body, symbolize_names: true)
          }
        }
      end

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

  path '/articles/{id}' do

    get('show article') do
      tags 'article'

      produces "application/json"

      parameter name: :id, in: :path, type: :integer, example: 1, required: :true

      after do |example|
        example.metadata[:response][:content] = {
          'application/json' => {
            example: JSON.parse(response.body, symbolize_names: true)
          }
        }
      end

      response(200, 'Successful request') do
        let!(:article) { Article.create(title: 'Article', body: 'Article text', status: 'public') }
        let!(:id) { 1 }
        schema '$ref' => '#components/schemas/article_show'

        run_test!
      end

      response(404, 'Invalid request (Id not found)') do
        let!(:article) { Article.create(id: 1, title: 'Article', body: 'Article text', status: 'public') }
        let!(:id) { 2 }
        schema '$ref' => '#/components/schemas/error'

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

      after do |example|
        example.metadata[:response][:content] = {
          'application/json' => {
            example: JSON.parse(response.body, symbolize_names: true)
          }
        }
      end

      response(200, 'Successful request') do
        let!(:article) { Article.create(title: 'Article', body: 'Article text', status: 'public') }
        let!(:params) { { title: 'Article update', body: 'Article text update', status: 'public' } }
        let!(:id) { 1 }

        schema '$ref' => '#components/schemas/article_show'

        run_test!
      end

      response(404, 'Invalid request (Id not found)') do
        let!(:article) { Article.create(title: 'Article', body: 'Article text', status: 'public') }
        let!(:params) { { title: 'Article update', body: 'Article text update', status: 'public' } }
        let!(:id) { 2 }
        schema '$ref' => '#/components/schemas/error'

        run_test!
      end
      
      response(422, 'Invalid request (Can not parse given data)') do
        let!(:article) { Article.create(title: '', body: 'Article text', status: 'public') }
        let!(:params) { { title: '', body: 'update', status: 'public' } }
        let!(:id) { 1 }
        schema '$ref' => '#/components/schemas/error'

        run_test!
      end
    end

    delete('delete article') do
      tags 'article'

      produces "application/json"

      parameter name: :id, in: :path, type: :integer, example: 1, required: :true

      after do |example|
        example.metadata[:response][:content] = {
          'application/json' => {
            example: JSON.parse(response.body, symbolize_names: true)
          }
        }
      end

      response(204, 'Successful request') do
        let!(:article) { Article.create(title: 'Article', body: 'Article text', status: 'public') }
        let(:id) { 1 }

        run_test!
      end

      response(404, 'Invalid request (Id not found)') do
        let!(:article) { Article.create(id: 1, title: 'Article', body: 'Article text', status: 'public') }
        let!(:id) { 2 }
        schema '$ref' => '#/components/schemas/error'

        run_test!
      end
    end
  end
end
