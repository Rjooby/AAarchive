class Vote < ActiveRecord::Base
  validates :value, inclusion: { in: [1, -1] }
  validates :votable_type, inclusion: { in: %w(post comment) }
  validates :value, :votable_id, :votable_type, presence: true

  belongs_to :votable, polymorphic: true
end
