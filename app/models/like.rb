class Like < ApplicationRecord
  belongs_to :author, foreign_key: :author_id, class_name: 'User'
  belongs_to :post, class_name: 'Post'

  after_save :update_post_like_counter
  after_destroy :decrement_post_like_counter

  private

  def update_post_like_counter
    post.increment!(:likes_counter)
  end

  def decrement_post_like_counter
    post.decrement!(:likes_counter)
    post.reload
  end
end
