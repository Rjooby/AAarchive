class Post < ActiveRecord::Base
  include Votable

  validates :title, :author_id, presence: true

  has_many :post_subs, inverse_of: :post

  has_many :subs, through: :post_subs

  has_many :comments

  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id
  )

  def top_level_comments
    self.comments.where(parent_comment_id: nil)
  end

  def comments_by_parent_id
    comment_hash = Hash.new { |h, k| h[k] = [] }
    self.comments.each do |comment|
      comment_hash[comment.parent_comment_id] << comment
    end
    comment_hash
  end
end
