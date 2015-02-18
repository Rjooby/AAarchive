class Sub < ActiveRecord::Base
  validates :title, :description, :moderator_id, presence: true
  validates :title, uniqueness: true

  has_many :post_subs, inverse_of: :sub
  has_many :posts, through: :post_subs

  belongs_to(
    :moderator,
    class_name: 'User',
    foreign_key: :moderator_id)
end

# post = Post.find(xxxxxx)
# subs = post.sub_ids
