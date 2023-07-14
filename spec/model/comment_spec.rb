require 'rails_helper'

RSpec.describe Comment, type: :model do
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

  subject(:comment) do
    Comment.new(text: 'A',
                author: user,
                post:)
  end

  it 'validates the length of text' do
    expect(subject).not_to be_valid
    expect(subject.errors[:text]).to include('3 characters is the minimum allowed')

    subject.text = 'A' * 251
    expect(subject).not_to be_valid
    expect(subject.errors[:text]).to include('250 characters is the maximum allowed')
  end
end
