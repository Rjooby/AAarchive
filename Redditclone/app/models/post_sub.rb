class PostSub < ActiveRecord::Base
  self.table_name = "posts_subs"

  validates :sub_id, presence: true

  belongs_to :post, inverse_of: :post_subs
  belongs_to :sub, inverse_of: :post_subs
end
