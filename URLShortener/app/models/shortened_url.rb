class ShortenedUrl < ActiveRecord::Base
  validates :short_url, presence: true, uniqueness: true
  validates :submitter_id, presence: true

  validate :not_flooding?
  validate :too_long?



  def self.random_code
    short = SecureRandom.urlsafe_base64
    while ShortenedUrl.exists?(short)
      short = SecureRandom.urlsafe_base64
    end

    short
  end

  def self.create_for_user_and_long_url!(user, long_url)

    ShortenedUrl.create!(submitter_id: user.id,
                         long_url: long_url,
                         short_url: self.random_code)

  end

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visits.select(:user_id).distinct.count
  end

  def num_recent_uniques
    self.visits.select(:user_id).where(created_at:
                10.minutes.ago..Time.now).count
  end

  has_many :visits,
            class_name: "Visit",
            foreign_key: :url_id

  has_many :unique_visits,
            -> {distinct},
            class_name: "Visit",
            foreign_key: :url_id

  has_many :tags,
            class_name: "Tagging",
            foreign_key: :url_index

  belongs_to :user,
              class_name: "User",
              foreign_key: :submitter_id

  # private

    def not_flooding?
      if self.user.shortened_urls.where(created_at: 1.minute.ago..Time.now).count > 5
        errors[:base] << "stop flooding, idiot"
      end
    end

    def too_long?
      if self.long_url.length > 1024
        errors[:base] << "too long"
      end
    end
end
