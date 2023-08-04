require 'rails_helper'

RSpec.describe 'Posts Show', type: :system do
  before(:each) do
    @user = User.create(name: 'Elham',
                        photo: 'https://media.istockphoto.com/id/1406197730/photo/portrait-of-a-young-handsome-indian-man.webp?b=1&s=170667a&w=0&k=20&c=KtmKHyOE6MJV0w2DiGX8P4399KHNbZ3p8lCjTEabGcY=',
                        bio: 'Best friends', posts_counter: 0)
    @post1 = @user.posts.create(title: 'Post 1', text: 'This is the first post.', comments_counter: 0, likes_counter: 0)
    @post2 = @user.posts.create(title: 'Post 2', text: 'This is the second post.', comments_counter: 0,
                                likes_counter: 0)
    @post3 = @user.posts.create(title: 'Post 3', text: 'This is the third post.', comments_counter: 0, likes_counter: 0)
    Comment.create(post: @post1, author: @user, text: 'This is a comment')
    Like.create(post: @post1, author: @user)
  end

  describe 'Post show page' do
    before(:each) do
      visit user_post_path(@user, @post1)
    end
    it 'displays the post title' do
      expect(page).to have_content('Post 1')
    end

    it 'displays the post author' do
      visit user_post_path(@user, @post1)
      expect(page).to have_content('Elham')
    end

    it 'displays the comments counter' do
      visit user_post_path(@user, @post1)
      expect(page).to have_content('Comments: 1')
    end

    it 'displays the likes counter' do
      visit user_post_path(@user, @post1)
      expect(page).to have_content('Likes: 1')
    end

    it 'displays the post body' do
      visit user_post_path(@user, @post1)
      expect(page).to have_content('This is the first post.')
    end

    it 'displays the user name of each commentor' do
      visit user_post_path(@user, @post1)
      expect(page).to have_content('Elham')
    end

    it 'displays the comment text' do
      visit user_post_path(@user, @post1)
      expect(page).to have_content('This is a comment')
    end
  end
end
