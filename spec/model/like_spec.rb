require 'rails_helper'

RSpec.describe Like, type: :model do
  user = User.new(name: 'Anything',
                  photo: 'http://licalhost:3000/anything.jpg',
                  bio: 'Anything test',
                  posts_counter: 0)
  post = Post.new(
    title: 'Anything',
    text: 'Anything test',
    author: user,
    comments_counter: 0,
    likes_counter: 0
  )
  
  describe 'associations' do
    it 'belongs to an author (User)' do
      association = described_class.reflect_on_association(:author)
      expect(association.macro).to eq(:belongs_to)
      expect(association.foreign_key).to eq(:author_id)
      expect(association.class_name).to eq('User')
    end

    it 'belongs to a post' do
      association = described_class.reflect_on_association(:post)
      expect(association.macro).to eq(:belongs_to)
      expect(association.class_name).to eq('Post')
    end
  end

  describe 'callbacks' do
    let(:user) { User.create(name: 'Anything',
        photo: 'http://licalhost:3000/anything.jpg',
        bio: 'Anything test',
        posts_counter: 0) }
    let(:post) { Post.create(  title: 'Anything',
        text: 'Anything test',
        author: user,
        comments_counter: 0,
        likes_counter: 0) }
    let(:like) { Like.new(author: user, post: post) }

    describe 'after_save' do
      it 'updates the post like counter' do
        expect { like.save }.to change { post.reload.likes_counter }.by(1)
      end
    end

    describe 'after_destroy' do
      before { like.save }

      it 'decrements the post like counter' do
        expect { like.destroy }.to change { post.reload.likes_counter }.by(-1)
      end
    end
  end
end



