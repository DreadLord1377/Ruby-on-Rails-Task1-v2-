require 'swagger_helper'

RSpec.describe 'articles', type: :request do

  path '/' do
    get('list articles (first 10)') do
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
        let!(:page) { 1 }
        let!(:per_page) { 10 }

        schema '$ref' => '#components/schemas/article_show_list'

        run_test!
      end
    end
  end

  path '/?page={page}' do
    get('list only necessary articles') do
      tags 'article'

      produces "application/json"

      parameter name: :page, in: :path, type: :integer, example: 1, required: :true

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
        let!(:page) { 1 }
        let!(:per_page) { 10 }

        schema '$ref' => '#components/schemas/article_show_list'

        run_test!
      end
    end
  end

  path '/?page={page}&per_page={per_page}' do
    get('list only necessary articles') do
      tags 'article'

      produces "application/json"

      parameter name: :page, in: :path, type: :integer, example: 1, required: :true
      parameter name: :per_page, in: :path, type: :integer, example: 10, required: :true

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
        let!(:page) { 1 }
        let!(:per_page) { 10 }

        schema '$ref' => '#components/schemas/article_show_list'

        run_test!
      end
    end
  end

  path '/articles' do
    get('list articles (first 10)') do
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
        let!(:page) { 1 }
        let!(:per_page) { 10 }

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

  path '/articles/?page={page}' do
    get('list only necessary articles') do
      tags 'article'

      produces "application/json"

      parameter name: :page, in: :path, type: :integer, example: 1, required: :true

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
        let!(:page) { 1 }
        let!(:per_page) { 10 }

        schema '$ref' => '#components/schemas/article_show_list'

        run_test!
      end
    end
  end

  path '/articles/?page={page}&per_page={per_page}' do
    get('list only necessary articles') do
      tags 'article'

      produces "application/json"

      parameter name: :page, in: :path, type: :integer, example: 1, required: :true
      parameter name: :per_page, in: :path, type: :integer, example: 10, required: :true

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
        let!(:page) { 1 }
        let!(:per_page) { 10 }

        schema '$ref' => '#components/schemas/article_show_list'

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
        if response.body.present?
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
      end

      response(200, 'Successful request') do
        let!(:article) { Article.create(title: 'Article', body: 'Article text', status: 'public') }
        let!(:id) { article.id }
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

      after do |example|
        if response.body.present?
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
      end

      response(200, 'Successful request') do
        let!(:article) { Article.create(title: 'Article', body: 'Article text', status: 'public') }
        let!(:params) { { title: 'Article update', body: 'Article text update', status: 'public' } }
        let!(:id) { article.id }

        schema '$ref' => '#components/schemas/article_show'

        run_test!
      end

      response(404, 'Invalid request (Id not found)') do
        let!(:params) { { title: 'Article update', body: 'Article text update', status: 'public' } }
        let!(:id) { 4534654 }

        run_test!
      end
      
      response(422, 'Invalid request (Can not parse given data)') do
        let!(:article) { Article.create(title: 'Article', body: 'Article text', status: 'public') }
        let!(:params) { { title: '', body: 'update', status: 'public' } }
        let!(:id) { article.id }
        schema '$ref' => '#/components/schemas/error'

        run_test!
      end
    end

    delete('delete article') do
      tags 'article'

      produces "application/json"

      parameter name: :id, in: :path, type: :integer, example: 1, required: :true

      after do |example|
        if response.body.present?
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
      end

      response(204, 'Successful request') do
        let!(:article) { Article.create(title: 'Article', body: 'Article text', status: 'public') }
        let(:id) { article.id }

        run_test!
      end

      response(404, 'Invalid request (Id not found)') do
        let!(:id) { 4534654 }

        run_test!
      end
    end
  end
end
