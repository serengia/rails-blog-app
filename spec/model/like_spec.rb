require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it 'belongs to an author (User)' do
      association = described_class.reflect_on_association(:author)
      expect(association.macro).to eq(:belongs_to)
      expect(association.foreign_key)
      expect(association.class_name).to eq('User')
    end

    it 'belongs to a post' do
      association = described_class.reflect_on_association(:post)
      expect(association.macro).to eq(:belongs_to)
      expect(association.class_name).to eq('Post')
    end
  end

  describe 'callbacks' do
    let(:user) { User.create(name: 'John', posts_counter: 0) }
    let(:post) { Post.create(title: 'My Post', comments_counter: 0, likes_counter: 0, author: user) }
    let(:like) { Like.new(author: user, post:) }

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
