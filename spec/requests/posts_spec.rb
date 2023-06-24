require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET #index' do
    it 'returns a success response' do
      get '/users/1/posts'
      expect(response).to be_successful
    end

    it 'renders the index template' do
      get '/users/1/posts'
      expect(response).to render_template(:index)
    end

    it 'includes the correct placeholder text in the response body' do
      get '/users/1/posts'
      expect(response.body).to include('Here is a list of posts for user #1')
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get '/users/1/posts/1'
      expect(response).to be_successful
    end

    it 'renders the show template' do
      get '/users/1/posts/1'
      expect(response).to render_template(:show)
    end

    it 'includes the correct placeholder text in the response body' do
      get '/users/1/posts/1'
      expect(response.body).to include('Here is post #1 for user #1')
    end
  end
end
