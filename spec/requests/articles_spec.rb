require 'swagger_helper'

RSpec.describe 'articles', type: :request do

  path '/' do
    get('list articles') do
      tags 'article'

      produces "application/json"

      response(200, 'Successful request') do
        schema '$ref' => '#components/schemas/article_show'

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end
    end
  end

  path '/articles' do
    get('list articles') do
      tags 'article'

      produces "application/json"

      response(200, 'Successful request') do
        schema '$ref' => '#components/schemas/article_show'

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

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

      response(201, 'Successful request') do
        let(:params) { { title: 'Article', body: 'Article text', status: 'public' } }
        schema '$ref' => '#components/schemas/article_preview'

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end

      response(422, 'Invalid request (Can not parse given data)') do
        schema '$ref' => '#/components/schemas/errors_object'
        run_test!
      end
    end
  end

  path '/articles/{id}' do

    get('show article') do
      tags 'article'

      produces "application/json"

      parameter name: :id, in: :path, type: :integer, example: 1, required: :true

      response(200, 'Successful request') do
        let(:id) { 1 }
        schema '$ref' => '#components/schemas/article_show'

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end

      response(404, 'Invalid request (Id not found)') do
        schema '$ref' => '#/components/schemas/errors_object'      
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

      response(200, 'Successful request') do
        let(:id) { 1 }
        let(:params) { { title: 'Article update', body: 'Article text update', status: 'public' } }
        schema '$ref' => '#components/schemas/article_preview'

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(404, 'Invalid request (Id not found)') do
        schema '$ref' => '#/components/schemas/errors_object'      
        run_test!
      end
      
      response(422, 'Invalid request (Can not parse given data)') do
        schema '$ref' => '#/components/schemas/errors_object'
        run_test!
      end
    end

    delete('delete article') do
      tags 'article'

      produces "application/json"

      parameter name: :id, in: :path, type: :integer, example: 1, required: :true

      response(200, 'Successful request') do
        let(:id) { 1 }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(404, 'Invalid request (Id not found)') do
        schema '$ref' => '#/components/schemas/errors_object'      
        run_test!
      end
    end
  end
end
