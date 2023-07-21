require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let!(:user) do
    User.create(name: 'Anything',
                photo: 'http://licalhost:3000/anything.jpg',
                bio: 'Anything test',
                posts_counter: 0)
  end

  let!(:post) do
    Post.create(
      title: 'Anything',
      text: 'Anything test',
      author: user,
      comments_counter: 0,
      likes_counter: 0
    )
  end

  describe 'Post GET /index' do
    it 'return post http success' do
      get "/users/#{user.id}/posts"
      expect(response).to have_http_status(200)
    end
    it 'rendered post template' do
      get "/users/#{user.id}/posts"
      expect(response).to render_template(:index)
    end
    it 'post responsed body with correct place holder' do
      get "/users/#{user.id}/posts"
      expect(response.body).to include('Posts by user')
    end
  end
  describe 'Post GET /show' do
    it 'return success for detail post' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to have_http_status(200)
    end
    it 'rendered post detail template' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to render_template(:show)
    end
    it 'post detail responsed body with correct place holder' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response.body).to include('Post details page')
    end
  end
end
