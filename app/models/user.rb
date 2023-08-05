class User < ApplicationRecord
  # Include default devise modules. Others available are:
  enum role: { user: "user", admin: "admin" }

  validates :role, presence: true

  # Set default role to 'user'
  after_initialize :set_default_role, if: :new_record?

  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  # Associations
  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy
  has_many :likes, foreign_key: :author_id, dependent: :destroy

  # Validations
  validates :name, presence: true, length: { minimum: 3, maximum: 50,
                                             too_long: '%<count>s characters is the maximum allowed' }
  validates :posts_counter, numericality: { only_integer: true },
                            comparison: { greater_than_or_equal_to: 0 }

  def three_most_recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  private

  def set_default_role
    self.role ||= :user
  end
end
