class Post < ApplicationRecord
  belongs_to :author, foreign_key: :author_id, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  after_save :update_user_post_counter

  validates :title, presence: true, length: { minimum: 5, maximum: 250,
                                              too_long: '%<count>s characters is the maximum allowed' }
  validates :comments_counter, numericality: { only_integer: true },
                               comparison: { greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true },
                            comparison: { greater_than_or_equal_to: 0 }

  def update_user_post_counter
    author.increment!(:posts_counter)
  end

  def five_most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
