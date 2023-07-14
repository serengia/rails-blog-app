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
    expect(subject.errors[:text]).to include('is too short (minimum is 3 characters)')

    subject.text = 'A' * 251
    expect(subject).not_to be_valid
    expect(subject.errors[:text]).to include('is too long (maximum is 250 characters)')
  end
end
