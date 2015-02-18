module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable, dependent: :destroy
  end

  def total_votes
    votes.map(&:value).inject(:+)
  end

end
