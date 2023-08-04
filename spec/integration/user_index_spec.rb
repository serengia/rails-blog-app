require 'rails_helper'

RSpec.describe 'User Index Page', type: :system do
  before(:each) do
    @user = User.create(name: 'Basir',
                        photo: 'https://media.istockphoto.com/id/1406197730/photo/portrait-of-a-young-handsome-indian-man.webp?b=1&s=170667a&w=0&k=20&c=KtmKHyOE6MJV0w2DiGX8P4399KHNbZ3p8lCjTEabGcY=',
                        bio: 'Best friends', posts_counter: 0)
    @user.posts.create(title: 'Post 1', text: 'This is the first post.', comments_counter: 0, likes_counter: 0)
    @user.posts.create(title: 'Post 2', text: 'This is the second post.', comments_counter: 0, likes_counter: 0)
    @user.posts.create(title: 'Post 3', text: 'This is the third post.', comments_counter: 0, likes_counter: 0)
  end

  describe 'User index page' do
    before(:each) { visit users_path }

    it 'displays a container for the users' do
      expect(page).to have_css('div.content')
    end

    it 'displays the username of each user' do
      User.all.each do |_user|
        expect(page).to have_content('Basir')
      end
    end

    it 'displays the photos of each user' do
      User.all.each do |_user|
        expect(page.has_xpath?("//img[@src='https://media.istockphoto.com/id/1406197730/photo/portrait-of-a-young-handsome-indian-man.webp?b=1&s=170667a&w=0&k=20&c=KtmKHyOE6MJV0w2DiGX8P4399KHNbZ3p8lCjTEabGcY=']"))
      end
    end

    it 'shows the number of posts of each user' do
      User.all.each do |_user|
        expect(page).to have_content('No of Posts: 3')
      end
    end

    it "is redirected to that user's show page" do
      click_link('Basir')
      visit user_path(@user)
      expect(page).to have_current_path(user_path(@user))
    end
  end
end
